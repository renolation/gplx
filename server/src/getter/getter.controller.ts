import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete, Query
} from "@nestjs/common";
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




  @Get('/url')
  findByUrl(@Query('link') link: string) {
    console.log(link);
    return this.getterService.findByUrl(`https://${link}`);
  }


  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.getterService.findOne(+id);
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
