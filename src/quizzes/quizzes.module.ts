import { Module } from '@nestjs/common';
import { QuizzesService } from './quizzes.service';
import { QuizzesController } from './quizzes.controller';
import { Answer } from "./entities/answer.entity";
import { Question } from "./entities/question.entity";
import { Chapter } from "./entities/chapter.entity";
import { Quiz } from "./entities/quiz.entity";
import { TypeOrmModule } from "@nestjs/typeorm";

@Module({
  imports: [TypeOrmModule.forFeature([Answer, Question, Chapter, Quiz
  ])],
  controllers: [QuizzesController],
  providers: [QuizzesService],
  exports: [QuizzesService],
})
export class QuizzesModule {}
