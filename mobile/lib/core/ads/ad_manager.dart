import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5869766193809960~2983702627";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5869766193809960~5890459222";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5869766193809960/9031295712";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5869766193809960/6380912805";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5869766193809960/6425329587";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5869766193809960/7873957872";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9131188183332364/4129202021";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/3986624511";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get appOpenAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5590864843607872/5397128841";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5590864843607872/9213951242";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}