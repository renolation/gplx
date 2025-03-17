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
            host: '103.188.82.191',
            port: 32770,
            username: 'root',
            password: 'Renolation29',
            database: 'postgres',
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
