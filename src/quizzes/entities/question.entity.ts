import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  OneToMany,
  JoinColumn,
} from 'typeorm';
import { Chapter } from './chapter.entity';
import { Answer } from './answer.entity';

@Entity('question')
export class Question {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  newColumn: number;

  @Column()
  chapterId: number;

  @Column()
  text: string;

  @Column()
  explain: string;

  @Column()
  type: string;

  @Column()
  isImportant: boolean;

  @Column()
  vehicle: string;

  @ManyToOne(() => Chapter, (chapter) => chapter.questions)
  chapter: Chapter;

  @OneToMany(() => Answer, (answer) => answer.question)
  answers: Answer[];
}
