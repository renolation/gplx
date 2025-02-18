
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'dart:convert';
import 'package:path_provider/path_provider.dart';

part 'boxes/settings.dart';


part 'boxes/common/box_keys.dart';
part 'boxes/common/main_box.dart';

part 'boxes/settings/general_extension.dart';


Future<void> initBoxes() async {

  await Hive.initFlutter();

  await SettingsBox().init();

}