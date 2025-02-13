part of '../boxes.dart';


class SettingsBox extends MainBox {
  static final _instance = SettingsBox._internal();

  factory SettingsBox() => _instance;

  SettingsBox._internal();

  @override
  String get boxKey => BoxKeys.hiveSettingsBox;
}
