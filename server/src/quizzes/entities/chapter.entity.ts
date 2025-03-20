import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import {Question} from "./question.entity";

@Entity('chapter')
export class Chapter {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  index: number;

  @Column()
  name: string;

  @Column()
  type: string;

  @Column(
    {
      nullable: true,
      default: false,
    }
  )
  isImportant: boolean;

  @OneToMany(() => Question, (question) => question.chapter)
  questions: Question[];
}
