import 'package:isar/isar.dart';

part 'settings_model.g.dart';

@collection
class SettingsModel {
  Id id = Isar.autoIncrement; // Unique ID for each entry

  @Index(unique: true)
  late String key; // Key for lookup

  late String value; // Value to store
}