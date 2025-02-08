import { Module } from '@nestjs/common';
import { GetterService } from './getter.service';
import { GetterController } from './getter.controller';
import { TypeOrmModule } from "@nestjs/typeorm";
import { Answer } from "../quizzes/entities/answer.entity";
import { Question } from "../quizzes/entities/question.entity";
import { Chapter } from "../quizzes/entities/chapter.entity";
import { Quiz } from "../quizzes/entities/quiz.entity";

@Module({
  imports: [TypeOrmModule.forFeature([Answer, Question, Chapter, Quiz
  ])],
  controllers: [GetterController],
  providers: [GetterService],
  exports: [GetterService],
})
export class GetterModule {}
