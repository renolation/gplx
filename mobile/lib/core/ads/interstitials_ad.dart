import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gplx_app/core/ads/ad_manager.dart';

class InterstitialAdProvider {

  InterstitialAdProvider._internal();
  static final InterstitialAdProvider _instance = InterstitialAdProvider._internal();
  factory InterstitialAdProvider() {
    return _instance;
  }

  InterstitialAd? _interstitialAd;
  static const AdRequest request = AdRequest();
  int _numInterstitialLoadAttempts = 0;
  static const int maxFailedLoadAttempts = 3;

  int count = 0;


  initAds() {
    createInterstitialAd();
  }

  createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdManager.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {
                  log('ad showed');
                },
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                  createInterstitialAd();
                },
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                  log('ad dismissed');
                  createInterstitialAd();
                },
                onAdClicked: (ad) {});
            log('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              Future.delayed(const Duration(minutes: 2)).then((value) => createInterstitialAd());
            }
          },
        ));
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    count++;
    print('show interstitial $count');
    if(count % 3 == 0) {
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }
}