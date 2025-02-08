import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { QuizzesModule } from './quizzes/quizzes.module';
import { Quiz } from './quizzes/entities/quiz.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GetterModule } from './getter/getter.module';
import { Answer } from "./quizzes/entities/answer.entity";
import { Chapter } from "./quizzes/entities/chapter.entity";
import { Question } from "./quizzes/entities/question.entity";

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      url: 'postgresql://postgres.bmkeuakzujzaerolpyga:Renolation29@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres',
      // ssl: {
      //   rejectUnauthorized: false,
      // },
      entities: [Quiz, Answer, Chapter, Question],
      synchronize: true,
    }),
    QuizzesModule,
    GetterModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
