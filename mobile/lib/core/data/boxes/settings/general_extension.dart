part of '../../boxes.dart';

extension GeneralSettings on SettingsBox {


  String get vehicleTypeQuestion {
    return box.get(
      BoxKeys.vehicleTypeQuestion,
      defaultValue: TypeEnum.b1.name,
    );
  }

  set vehicleTypeQuestion(String value) {
    box.put(BoxKeys.vehicleTypeQuestion, value);
  }
}
