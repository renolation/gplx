import {
    Entity,
    PrimaryGeneratedColumn,
    Column,
    ManyToOne,
    OneToMany, ManyToMany,
} from 'typeorm';
import {Chapter} from './chapter.entity';
import {Answer} from './answer.entity';
import {Quiz} from "./quiz.entity";

@Entity('question')
export class Question {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    index: number;

    @Column()
    text: string;

    @Column({nullable: true})
    image: string;

    @Column({nullable: true})
    explain: string;

    @Column({default: false})
    isImportant: boolean;

    @Column()
    vehicle: string;

    @ManyToOne(() => Chapter, (chapter) => chapter.questions)
    chapter: Chapter;

    @OneToMany(() => Answer, (answer) => answer.question)
    answers: Answer[];

    @ManyToMany(() => Quiz, (quiz) => quiz.questions)
    quizzes: Quiz[];
}
