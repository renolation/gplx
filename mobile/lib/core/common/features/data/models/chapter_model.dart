import 'package:equatable/equatable.dart';
import 'package:gplx_app/core/common/features/domain/entities/chapter_entity.dart';
import 'question_model.dart';
import 'dart:convert';
import 'package:hive_ce/hive.dart';

part 'chapter_model.g.dart';


List<ChapterModel> chapterModelFromJson(String str) => List<ChapterModel>.from(json.decode(str).map((x) => ChapterModel.fromJson(x)));

String chapterModelToJson(List<ChapterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


@HiveType(typeId: 2)
class ChapterModel extends ChapterEntity {

  @HiveField(0)
  final int id;

  @HiveField(1)
  final int index;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final List<QuestionModel> questions;

  @HiveField(4)
  final bool isImportant;

  @HiveField(5)
  final String vehicle;



  const ChapterModel({
    required this.id,
    required this.index,
    required this.name,
    this.questions = const [],
    this.isImportant = false,
    required this.vehicle,
  }): super(
    id: id,
    index: index,
    name: name,
    questions: questions,
    );

   ChapterModel copyWith({
    int? id,
    int? index,
    String? name,
    List<QuestionModel>? questions,
     bool? isImportant,
     String? vehicle,
  }) {
    return ChapterModel(
      id: id ?? this.id,
      index: index ?? this.index,
      name: name ?? this.name,
      questions: questions ?? this.questions,
      isImportant: isImportant ?? this.isImportant,
      vehicle: vehicle ?? this.vehicle,
    );
  }

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'] as int,
      index: json['index'] as int,
      name: json['name'] as String,
      isImportant: json['isImportant'] as bool,
      vehicle: json['vehicle'] as String,
      questions: (json['question'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'index': index,
      'name': name,
      'isImportant': isImportant,
      'vehicle': vehicle,
      'questions': questions.map((e) => (e as QuestionModel).toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, index, name, questions, isImportant, vehicle];
}
