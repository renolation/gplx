import {Injectable} from "@nestjs/common";
import {CreateGetterDto} from "./dto/create-getter.dto";
import {UpdateGetterDto} from "./dto/update-getter.dto";
import {PlaywrightCrawler} from "@crawlee/playwright";
import {Quiz} from "../quizzes/entities/quiz.entity";
import {Repository} from "typeorm";
import {InjectRepository} from "@nestjs/typeorm";
import {Answer} from "../quizzes/entities/answer.entity";
import {Chapter} from "../quizzes/entities/chapter.entity";
import {Question} from "../quizzes/entities/question.entity";
import {Sign} from "../quizzes/entities/sign.entity";

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
        @InjectRepository(Sign)
        private signRepository: Repository<Sign>
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

    async getSign() {
        const crawler = new PlaywrightCrawler({
                requestHandler: async ({page, request, enqueueLinks}) => {
                    await page.waitForTimeout(1500);

                    const rows = page.locator('.row.tips');
                    const row = rows.nth(2);

                    const divs = row.locator('div[id^="group"]');
                    const tables = row.locator('table');

                    const divCount = await divs.count();
                    const tableCount = await tables.count();

                    if (divCount !== tableCount) {
                        console.error("Mismatch between number of divs and tables");
                    } else {
                        const mappings = [];
                        for (let i = 0; i < divCount; i++) {
                            const div = divs.nth(i);
                            const headerName = await div.textContent();


                            const table = tables.nth(i);
                            const trCount = await table.locator('tbody tr').count();

                            console.log(trCount);

                            // console.log(await table.innerHTML());
                            const trItem = table.locator('tr');
                            const tdItemCount = await trItem.count();
                            for (let j = 0; j < tdItemCount; j++) {
                                console.log(headerName.trim());
                                const imgTag = await trItem.nth(j).locator('.sign').locator('img').getAttribute("src");
                                console.log(imgTag);

                                const signDesc = await trItem.nth(j).locator('.sign_desc');
                                const textBold = signDesc.locator('.text_bold');
                                const primaryText = await textBold.locator('.text_primary').textContent();
                                const boldText = await textBold.evaluate(node => node.childNodes[0].textContent.trim());

                                const descDiv = await signDesc.locator("div").nth(1).textContent();


                                console.log(`Bold Text: ${boldText}`);
                                console.log(`Primary Text: ${primaryText}`);
                                console.log(descDiv.trim());
                                console.log('-----------')
                                const sign = new Sign();
                                sign.name = primaryText;
                                sign.bold = boldText;
                                sign.desc = descDiv;
                                sign.image = imgTag;
                                sign.type = headerName
                                await this.saveSignToDB(sign);


                            }


                            // for (let i = 0; i< 1; i++) {
                            //     const imageSrc = table.nth(i);
                            //     const sign = imageSrc.locator("td.sign").first();
                            //     console.log(sign.innerHTML());
                            //     // const img =  imageSrc.locator('img').first();
                            //     // console.log(img.getAttribute("src"));
                            //     // console.log(img.getAttribute("data-src"));
                            // }

                            mappings.push({headerName, table});
                        }

                        // console.log(mappings);
                    }


                }
            }
        );
        await crawler.run(['https://taplaixe.vn/cac-bien-bao-giao-thong']);
    }

    async getQuiz(urls: string[]) {
        const crawler = new PlaywrightCrawler({
            maxConcurrency: 1,
            requestHandler: async ({page, request, enqueueLinks}) => {
                while (await page.locator("#btnStartExam").first().isVisible()) {
                    const currentUrl = page.url();
                    console.log(`Current URL: ${currentUrl}`);
                    await page.waitForTimeout(1500);
                    await page.locator("#btnStartExam").first().click();
                    await page.waitForTimeout(1500);


                    const parentDiv = page.locator('.col-md-9.col-sm-9.col-xs-9.flex-stack');
                    const secondChildDiv = parentDiv.locator('div:nth-child(2)');
                    const listItems = secondChildDiv.locator('div.question-body');

                    const quizNameElement = page.locator('.flex.border-bottom p:has-text("Đề ")');
                    const quizName = await quizNameElement.textContent();
                    console.log(`Quiz Name: ${quizName}`);

                    const count = await listItems.count();
                    let countOfCorrectQuestions = 0;

                    for (let i = 0; i < count; i++) {
                        const listItem = listItems.nth(i);
                        const answers = listItem.locator("blockquote a");
                        const questionText = await listItem.locator(".question_content").textContent();
                        const answerTexts = [];


                        const image = listItem.locator("img");
                        let imgSrc = '';
                        for (let j = 0; j < await image.count(); j++) {
                            imgSrc = await image.nth(j).getAttribute("data-src");
                            console.log(`Image Source: ${imgSrc}`);
                        }


                        for (let i = 0; i < await answers.count(); i++) {
                            let answerText = await answers.nth(i).textContent();
                            answerText = answerText.trim();
                            answerTexts.push(answerText);
                        }

                        const questions = await this.questionRepository.find({
                            where: {text: questionText, vehicle: 'Moto', image: imgSrc === '' ? null : imgSrc},
                            relations: {
                                answers: true
                            }
                        });

                        let correctQuestion = null;
                        if (questions.length === 1) {
                            correctQuestion = questions[0];
                        } else {
                            for (const question of questions) {
                                const questionAnswerTexts = question.answers.map(a => a.text);
                                if (answerTexts.every((answer, index) => answer === questionAnswerTexts[index])) {
                                    correctQuestion = question;
                                    break;
                                }
                            }
                        }


                        if (correctQuestion) {
                            console.log(`Question: ${correctQuestion.text}`);
                            const quiz = new Quiz();
                            quiz.name = quizName;
                            quiz.type = "A1";
                            countOfCorrectQuestions++;
                            await this.saveQuestionToQuiz(correctQuestion, quiz);

                        } else {
                            console.log("Correct question not found");
                        }
                    }
                    console.log(`Count of list items: ${countOfCorrectQuestions}`);

                }
            },
            requestHandlerTimeoutSecs: 5000,
            // headless: false,
        });
        await crawler.run(urls);
    }


    async findByUrl(url: string) {
        console.log(`Finding by url: ${url}`);
        const crawler = new PlaywrightCrawler({
            requestHandler: async ({page, request, enqueueLinks}) => {
                console.log(`Processing: ${request.url}`);
                await page.waitForTimeout(1000);
                const urlObj = new URL(request.url);
                while (await page.locator(".btn-next").first().isVisible()) {
                    const body = page.locator(".question-body");
                    const questionBody = await page
                        .locator(".question-body")
                        .textContent();
                    // console.log(`Question Body: ${questionBody}`);
                    const questionIndex = (
                        await body.locator(".question_txt").textContent()
                    )
                        .replace("Câu hỏi ", "")
                        .replace(":", "");
                    console.log(`Question index: ${questionIndex}`);
                    const questionContent = await body
                        .locator(".question_content b")
                        .textContent();

                    const firstImg = body.locator("img").first();
                    let imgSrc = '';
                    if (await firstImg.count() > 0) {
                        imgSrc = await firstImg.getAttribute("src");
                        console.log(`Image Source: ${imgSrc}`);
                    } else {
                        console.log("No image found");
                    }

                    let explainText = "";
                    if (await body.locator(".quest_explation .text_bold").count() > 0) {
                        explainText = await body.locator(".quest_explation .text_bold").textContent();
                    }

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
                    const type = url.match('600') ? 'Oto' : 'Moto';
                    const chapter = await this.saveChapterToDB(firstChapter, type);
                    // console.log(chapter);

                    //endregion

                    const questionEntity = new Question();
                    questionEntity.index = parseInt(questionIndex);
                    questionEntity.text = questionContent;
                    questionEntity.explain = explainText ?? '';
                    questionEntity.vehicle = type;
                    questionEntity.chapter = chapter;
                    questionEntity.image = imgSrc;
                    console.log(questionContent);
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
                    await page.waitForTimeout(600);
                }
            },
            requestHandlerTimeoutSecs: 30000,
            headless: false
        });
        await crawler.run([url]);
    }

    async saveQuestionToQuiz(question: Question, quiz: Quiz): Promise<Quiz> {
        const isExist = await this.quizRepository.findOne({
            where: {name: quiz.name, type: quiz.type},
            relations: {questions: true}
        });
        if (isExist) {
            if (!isExist.questions) {
                isExist.questions = [];
            }
            isExist.questions.push(question);
            return this.quizRepository.save(isExist);
        } else {
            quiz.questions = [question];
            return this.quizRepository.save(quiz);
        }
    }


    async saveQuestionToDB(question: Question): Promise<Question> {
        const isExist = await this.questionRepository.findOne({
            where: {index: question.index, text: question.text, vehicle: question.vehicle}
        });
        if (isExist) {
            if ((question.chapter.index === 8 && question.chapter.type === 'Oto') || (question.chapter.index === 4 && question.chapter.type === 'Moto')) {
                isExist.isImportant = true;
                return this.questionRepository.save(isExist);
            }
        } else {
            return this.questionRepository.save(question);
        }

    }

    async saveSignToDB(sign: Sign): Promise<Sign> {
        const isExist = await this.signRepository.findOne({
            where: {name: sign.name, type: sign.type, bold: sign.bold, image: sign.image},
        });
        if (isExist) {
            return isExist;
        } else {
            return this.signRepository.save(sign);
        }
    }

    async saveAnswerToDB(answer: Answer, question: Question): Promise<Answer> {
        const isExist = await this.answerRepository.findOne({
            where: {text: answer.text, question: question}
        });
        if (isExist) {
            // console.log("Answer is exist");
            return isExist;
        }
        answer.question = question;
        return this.answerRepository.save(answer);
    }

    async saveChapterToDB(text: string, type: string): Promise<Chapter> {
        const regex = /Chương (\d+): (.+)/;
        const match = text.match(regex);
        if (match) {
            const chapterNumber = match[1];
            const description = match[2];
            const isExist = await this.chapterRepository.findOne({
                where: {index: parseInt(chapterNumber), name: description, type: type}
            });
            if (isExist) {
                // console.log("Chapter is exist");
                return isExist;
            } else {
                const chapter = new Chapter();
                chapter.index = parseInt(chapterNumber);
                chapter.name = description;
                chapter.type = type;
                return this.chapterRepository.save(chapter);
            }
        } else {
            console.log("No match found");
        }
    }
}
