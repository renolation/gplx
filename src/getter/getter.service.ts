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
        private questionRepository: Repository<Question>,

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
          const questionText = (await body
            .locator(".question_txt")
            .textContent()).replace("Câu hỏi ", "").replace(":", "");
          console.log(`Question Text: ${questionText}`);
          const questionContent = await body
            .locator(".question_content b")
            .textContent();
          // console.log(`Question Content: ${questionContent}`);
          const answers = page.locator("blockquote a");
          const results = [];
          const count = await answers.count();
          for (let i = 0; i < count; i++) {
            const answer = answers.nth(i);
            const text = await answer.textContent();
            const isTrue = await answer.evaluate((node) =>
              node.classList.contains("answer-Y"),
            );
            results.push({ text, isTrue });
          }
          // console.log(results);
          await page.locator(".btn-next").first().click();
          await page.waitForTimeout(500);
        }
      },
      requestHandlerTimeoutSecs: 3000,
    });
    await crawler.run([url]);
  }
}
