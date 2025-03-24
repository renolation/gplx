import 'package:gplx_app/core/common/features/domain/entities/sign_entity.dart';
import 'package:hive_ce/hive.dart';

import 'dart:convert';

part 'sign_model.g.dart';

List<SignModel> signModelFromJson(String str) =>
    List<SignModel>.from(json.decode(str).map((x) => SignModel.fromJson(x)));

String signModelToJson(List<SignModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 4)
class SignModel extends SignEntity {

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String desc;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String bold;

  @HiveField(5)
  final String type;

  const SignModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
    required this.bold,
    required this.type,
  }) : super(
    id: id,
    name: name,
    desc: desc,
    image: image,
    bold: bold,
    type: type,
  );

  SignModel copyWith({
    int? id,
    String? name,
    String? desc,
    String? image,
    String? bold,
    String? vehicle,
  }) {
    return SignModel(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      image: image ?? this.image,
      bold: bold ?? this.bold,
      type: vehicle ?? this.type,
    );
  }

  factory SignModel.fromJson(Map<String, dynamic> json) {
    return SignModel(
      id: json['id'] as int,
      name: json['name'] as String,
      desc: json['desc'] as String,
      image: json['image'] as String,
      bold: json['bold'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'image': image,
      'bold': bold,
      'type': type,
    };
  }
}
