import {
    Column,
    Entity,
    PrimaryGeneratedColumn, ManyToOne,
    OneToMany,
    ManyToMany, JoinTable,
} from 'typeorm';
import { Question } from './question.entity';

@Entity()
export class Quiz {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({nullable: true})
    name: string;

    @Column({nullable: true})
    type: string;
    //note: change vehicle to type: A1, A2, B1, B2, C1, C2...

    @ManyToMany(() => Question, (question) => question.quizzes)
    @JoinTable()
    questions: Question[];
}
