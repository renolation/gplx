import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5590864843607872~4455242957";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5869766193809960~5890459222";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5590864843607872/6710210513";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2435281174";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5590864843607872/1649455526";
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