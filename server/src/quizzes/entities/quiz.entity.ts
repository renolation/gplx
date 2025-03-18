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
    vehicle: string;

    @ManyToMany(() => Question, (question) => question.quizzes)
    @JoinTable()
    questions: Question[];
}
