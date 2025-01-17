import { PartialType } from '@nestjs/mapped-types';
import { CreateGetterDto } from './create-getter.dto';

export class UpdateGetterDto extends PartialType(CreateGetterDto) {}
