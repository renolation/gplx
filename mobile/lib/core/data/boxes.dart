
import 'package:gplx_app/core/common/features/data/models/answer_model.dart';
import 'package:gplx_app/core/common/features/data/models/chapter_model.dart';
import 'package:gplx_app/core/common/features/data/models/question_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'dart:convert';
import 'package:path_provider/path_provider.dart';

part 'boxes/settings.dart';
part 'boxes/questions.dart';


part 'boxes/common/box_keys.dart';
part 'boxes/common/main_box.dart';

part 'boxes/settings/general_extension.dart';
part 'boxes/questions/learn_extension.dart';
part 'boxes/questions/base_extension.dart';


Future<void> initBoxes() async {

  await Hive.initFlutter();
  Hive.registerAdapter(QuestionModelAdapter());
  Hive.registerAdapter(AnswerModelAdapter());
  Hive.registerAdapter(ChapterModelAdapter());
  await SettingsBox().init();
  await QuestionsBox().init();

}