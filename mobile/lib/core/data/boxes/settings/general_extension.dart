part of '../../boxes.dart';

extension GeneralSettings on SettingsBox {
  bool get hasFinishedOnboarding {
    final value = isar.settingsModels
        .filter()
        .keyEqualTo(BoxKeys.hasFinishedOnboarding)
        .findFirstSync();
    return value?.value == 'true';
  }

  set hasFinishedOnboarding(bool value)  {
    var currentValue = hasFinishedOnboarding;
    currentValue = !currentValue;
     isar.settingsModels.put(SettingsModel()
      ..key = BoxKeys.hasFinishedOnboarding
      ..value = currentValue.toString());

  }
}
