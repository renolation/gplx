import 'package:equatable/equatable.dart';


class SignEntity extends Equatable {
  const SignEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.desc,
    required this.bold,
    required this.type,
  });

  final int id;
  final String name;
  final String image;
  final String desc;
  final String bold;
  final String type;

  @override
  List<Object?> get props => [id, name, image, desc, bold, type];
}

