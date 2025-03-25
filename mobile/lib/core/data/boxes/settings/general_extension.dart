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


  List<SignModel> get listSigns {
    return (box.get(
      BoxKeys.listSigns,
      defaultValue: [],
    ) as List).cast<SignModel>();
  }

  set listSigns(List<SignModel> value) {
    if (value.isEmpty) {
      box.delete(BoxKeys.listSigns);
      return;
    }
    box.put(BoxKeys.listSigns, value);
  }
}
