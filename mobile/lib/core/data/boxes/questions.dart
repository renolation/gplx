part of '../boxes.dart';


class QuestionsBox extends MainBox {
  static final _instance = QuestionsBox._internal();

  factory QuestionsBox() => _instance;

  QuestionsBox._internal();

  @override
  String get boxKey => BoxKeys.hiveQuestionsBox;
}