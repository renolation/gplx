import {
    Controller,
    Get,
    Post,
    Body,
    Patch,
    Param,
    Delete, Query
} from "@nestjs/common";
import {GetterService} from './getter.service';
import {CreateGetterDto} from './dto/create-getter.dto';
import {UpdateGetterDto} from './dto/update-getter.dto';

@Controller('getter')
export class GetterController {
    constructor(private readonly getterService: GetterService) {
    }

    @Post()
    create(@Body() createGetterDto: CreateGetterDto) {
        return this.getterService.create(createGetterDto);
    }


    @Get("/quiz")
    getQuiz() {
       const urls = Array.from({ length: 20 }, (_, i) => `https://taplaixe.vn/thi-thu-ly-thuyet-lai-xe-hang-b11?dethi=${i + 1}`);
        console.log(urls);
        return this.getterService.getQuiz(urls);
    }

    @Get('/url')
    findByUrl(@Query('link') link: string) {

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
