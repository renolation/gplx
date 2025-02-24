part of '../../boxes.dart';

extension GeneralSettings on SettingsBox {
  bool get hasFinishedOnboarding {
    return box.get(
      BoxKeys.hasFinishedOnboarding,
      defaultValue: false,
    );
  }

  set hasFinishedOnboarding(bool value) {
    box.put(BoxKeys.hasFinishedOnboarding, value);
  }

  String get vehicleTypeQuestion {
    return box.get(
      BoxKeys.vehicleTypeQuestion,
      defaultValue: 'B1',
    );
  }

  set vehicleTypeQuestion(String value) {
    box.put(BoxKeys.vehicleTypeQuestion, value);
  }
}
