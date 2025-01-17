import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { GetterService } from './getter.service';
import { CreateGetterDto } from './dto/create-getter.dto';
import { UpdateGetterDto } from './dto/update-getter.dto';

@Controller('getter')
export class GetterController {
  constructor(private readonly getterService: GetterService) {}

  @Post()
  create(@Body() createGetterDto: CreateGetterDto) {
    return this.getterService.create(createGetterDto);
  }

  @Get()
  findAll() {
    return this.getterService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.getterService.findOne(+id);
  }

  @Get('/url/:url')
  findByUrl(@Param('url') url: string) {
    return this.getterService.findByUrl(`https://${url}`);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateGetterDto: UpdateGetterDto) {
    return this.getterService.update(+id, updateGetterDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.getterService.remove(+id);
  }
}
