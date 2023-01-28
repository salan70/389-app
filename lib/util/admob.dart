import 'dart:io';

import 'package:baseball_quiz_app/util/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// InterstitialAdの作成、表示を行うクラス
class MyInterstitialAd {
  InterstitialAd? _interstitialAd;

  /// 広告を作成する
  Future<void> createAd() async {
    await InterstitialAd.load(
      adUnitId: await _selectInterstitialId(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: logger.e,
      ),
    );
  }

  Future<String> _selectInterstitialId() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appName = packageInfo.appName;

    // prod環境の場合
    if (appName == '.389') {
      return Platform.isAndroid
          ? dotenv.env['INTERSTITIAL_ID_ANDROID']!
          : dotenv.env['INTERSTITIAL_ID_IOS']!;
    }

    // prod環境以外の場合
    return Platform.isAndroid
        ? dotenv.env['TEST_INTERSTITIAL_ID_ANDROID']!
        : dotenv.env['TEST_INTERSTITIAL_ID_IOS']!;
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

class MyBannerAd {
  Future<BannerAd> createBannerAd() async {
    return BannerAd(
      adUnitId: await _selectBannerId(),
      size: AdSize.banner,
      request: const AdRequest(
        nonPersonalizedAds: true,
      ),
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          logger.e(error);
        },
      ),
    );
  }

  Future<String> _selectBannerId() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appName = packageInfo.appName;

    // prod環境の場合
    if (appName == '.389') {
      return Platform.isAndroid
          ? dotenv.env['BANNER_ID_ANDROID']!
          : dotenv.env['BANNER_ID_IOS']!;
    }

    // prod環境以外の場合
    return Platform.isAndroid
        ? dotenv.env['TEST_BANNER_ID_ANDROID']!
        : dotenv.env['TEST_BANNER_ID_IOS']!;
  }
}
