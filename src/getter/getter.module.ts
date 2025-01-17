import { Module } from '@nestjs/common';
import { GetterService } from './getter.service';
import { GetterController } from './getter.controller';

@Module({
  controllers: [GetterController],
  providers: [GetterService],
})
export class GetterModule {}
