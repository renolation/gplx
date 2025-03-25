
enum TypeEnum {
  a1('A1', 'Moto'),
  b1('B1', 'Oto');

  const TypeEnum(this.name, this.desc);
  final String name;
  final String desc;
}

extension TypeEnumExtension on String {
  convertToVehicle() {
    switch (this) {
      case 'A1':
        return 'Moto';
      case 'B1':
        return 'Oto';
    }
  }
}