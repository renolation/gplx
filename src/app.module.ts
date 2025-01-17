import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { QuizzesModule } from './quizzes/quizzes.module';
import { Quiz } from './quizzes/entities/quiz.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'ep-rough-thunder-155355.ap-southeast-1.aws.neon.tech',
      port: 5432,
      username: 'vodanh.2901',
      password: 'kh92JHlIDjWV',
      database: 'gplx',
      ssl: {
        rejectUnauthorized: false,
      },
      entities: [Quiz],
      synchronize: true,
    }),
    QuizzesModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
