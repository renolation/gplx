import { Injectable } from "@nestjs/common";
import { CreateGetterDto } from "./dto/create-getter.dto";
import { UpdateGetterDto } from "./dto/update-getter.dto";
import { PlaywrightCrawler } from "@crawlee/playwright";
import { Quiz } from "../quizzes/entities/quiz.entity";
import { Repository } from "typeorm";
import { InjectRepository } from "@nestjs/typeorm";
import { Answer } from "../quizzes/entities/answer.entity";
import { Chapter } from "../quizzes/entities/chapter.entity";
import { Question } from "../quizzes/entities/question.entity";

@Injectable()
export class GetterService {
  constructor(
    @InjectRepository(Quiz)
    private quizRepository: Repository<Quiz>,
    @InjectRepository(Answer)
    private answerRepository: Repository<Answer>,
    @InjectRepository(Chapter)
    private chapterRepository: Repository<Chapter>,
    @InjectRepository(Question)
    private questionRepository: Repository<Question>
  ) {
  }

  create(createGetterDto: CreateGetterDto) {
    return `This action adds a new getter ${createGetterDto}`;
  }

  findAll() {
    return `This action returns all getter`;
  }

  findOne(id: number) {
    return `This action returns a #${id} getter`;
  }

  update(id: number, updateGetterDto: UpdateGetterDto) {
    return `This action updates a #${id} getter ${updateGetterDto}`;
  }

  remove(id: number) {
    return `This action removes a #${id} getter`;
  }

  async findByUrl(url: string) {
    console.log(`Finding by url: ${url}`);
    const crawler = new PlaywrightCrawler({
      requestHandler: async ({ page, request, enqueueLinks }) => {
        console.log(`Processing: ${request.url}`);
        await page.waitForTimeout(1000);
        const urlObj = new URL(request.url);
        while (await page.locator(".btn-next").first().isVisible()) {
          const body = page.locator(".question-body");
          const questionBody = await page
            .locator(".question-body")
            .textContent();
          // console.log(`Question Body: ${questionBody}`);
          const questionText = (
            await body.locator(".question_txt").textContent()
          )
            .replace("Câu hỏi ", "")
            .replace(":", "");
          console.log(`Question Text:                            ${questionText}`);
          const questionContent = await body
            .locator(".question_content b")
            .textContent();
          // console.log(`Question Content: ${questionContent}`);
          const answers = page.locator("blockquote a");
          const results = [];
          const count = await answers.count();

          //region chapter
          const firstChapter = await page
            .locator(".questions div.chapter-no[style='']")
            .locator(".chapter-title")
            .first()
            .textContent();
          const chapter = await this.saveChapterToDB(firstChapter);
          // console.log(chapter);

          //endregion

          const questionEntity = new Question();
          questionEntity.index = parseInt(questionText);
          questionEntity.text = questionText;
          questionEntity.explain = questionContent;
          questionEntity.type = "A1";
          questionEntity.vehicle = "B";
          questionEntity.chapter = chapter;
          const question = await this.saveQuestionToDB(questionEntity);

          for (let i = 0; i < count; i++) {
            const answer = answers.nth(i);
            const text = await answer.textContent();
            const isTrue = await answer.evaluate((node) =>
              node.classList.contains("answer-Y")
            );
            const answerEntity = new Answer();
            answerEntity.text = text;
            answerEntity.isCorrect = isTrue;
            await this.saveAnswerToDB(answerEntity, question);
          }
          // console.log(results);
          await page.locator(".btn-next").first().click();
          await page.waitForTimeout(500);
        }
      },
      requestHandlerTimeoutSecs: 30000,
      // headless: false
    });
    await crawler.run([url]);
  }

  async saveQuestionToDB(question: Question): Promise<Question> {
    const isExist = await this.questionRepository.findOne({
      where: { index: question.index, text: question.text, chapter: question.chapter }
    });
    if (isExist) {
      // console.log("Question is exist");
      return isExist;
    }
    return this.questionRepository.save(question);
  }

  async saveAnswerToDB(answer: Answer, question: Question): Promise<Answer> {
    const isExist = await this.answerRepository.findOne({
      where: { text: answer.text, question: question }
    });
    if (isExist) {
      // console.log("Answer is exist");
      return isExist;
    }
    answer.question = question;
    return this.answerRepository.save(answer);
  }

  async saveChapterToDB(text: string): Promise<Chapter> {
    const regex = /Chương (\d+): (.+)/;
    const match = text.match(regex);
    if (match) {
      const chapterNumber = match[1];
      const description = match[2];

      const isExist = await this.chapterRepository.findOne({
        where: { index: parseInt(chapterNumber), name: description }
      });
      if (isExist) {
        // console.log("Chapter is exist");
        return isExist;
      } else {
        const chapter = new Chapter();
        chapter.index = parseInt(chapterNumber);
        chapter.name = description;
        return this.chapterRepository.save(chapter);
      }
    } else {
      console.log("No match found");
    }
  }
}
