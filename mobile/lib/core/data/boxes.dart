

import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:gplx_app/core/data/boxes/settings/settings_model.dart';
import 'package:gplx_app/core/data/secure_storage.dart';
import 'package:isar/isar.dart';

part 'boxes/settings.dart';


part 'boxes/common/box_keys.dart';
part 'boxes/common/main_box.dart';

part 'boxes/settings/general_extension.dart';


Future<void> initBoxes() async {
  await SecureStorage().init();

  await Isar.initializeIsarCore();

  await SettingsBox().init();

}