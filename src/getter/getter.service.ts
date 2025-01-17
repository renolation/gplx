import { Injectable } from '@nestjs/common';
import { CreateGetterDto } from './dto/create-getter.dto';
import { UpdateGetterDto } from './dto/update-getter.dto';
import {log, PlaywrightCrawler} from '@crawlee/playwright';

@Injectable()
export class GetterService {
  create(createGetterDto: CreateGetterDto) {
    return 'This action adds a new getter';
  }

  findAll() {
    return `This action returns all getter`;
  }

  findOne(id: number) {
    return `This action returns a #${id} getter`;
  }

  update(id: number, updateGetterDto: UpdateGetterDto) {
    return `This action updates a #${id} getter`;
  }

  remove(id: number) {
    return `This action removes a #${id} getter`;
  }

  async findByUrl(url: string) {
    const crawler = new PlaywrightCrawler({
      requestHandler: async ({ page, request, enqueueLinks }) => {
        console.log(`Processing: ${request.url}`);
        await page.waitForTimeout(1000);
        const urlObj = new URL(request.url);
        const domain = urlObj.origin;
        console.log(`Domain: ${domain}`);

        await enqueueLinks({
          selector: '.types .type:not(:first-child)',
          baseUrl: domain,
        });

      },
    });
    await crawler.run([`https://taplaixe.vn/`]);
  }
}
