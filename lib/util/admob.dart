import 'dart:io';

import 'package:baseball_quiz_app/util/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// InterstitialAdの作成、表示を行うクラス
class MyInterstitialAd {
  InterstitialAd? _interstitialAd;

  /// 広告を作成する
  Future<void> createAd() async {
    await InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? dotenv.env['TEST_INTERSTITIAL_ID_ANDROID']!
          : dotenv.env['TEST_INTERSTITIAL_ID_IOS']!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: logger.e,
      ),
    );
  }

  /// 広告を表示する
  Future<void> showAd() async {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        logger.e(error);
        ad.dispose();
        createAd();
      },
    );

    await _interstitialAd!.show();
    _interstitialAd = null;
  }
}
