import {Column, Entity, PrimaryGeneratedColumn} from "typeorm";


@Entity('sign')
export class Sign {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;

    @Column()
    image: string;

    @Column({nullable: true})
    desc: string;

    @Column()
    type: string;
}