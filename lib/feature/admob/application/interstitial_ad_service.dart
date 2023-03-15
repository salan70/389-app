import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../util/logger.dart';
import '../../loading/application/loading_state.dart';

final interstitialAdServiceProvider = Provider(
  InterstitialAdService.new,
);

/// InterstitialAd関連の処理を行うサービスクラス
class InterstitialAdService {
  InterstitialAdService(this.ref);

  final Ref ref;
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

  /// ランダムで広告を表示する
  Future<void> randomShowAd() async {
    if (isShownAds()) {
      await showAd();
    }
  }

  // TODO(me): 仮置でここのクラスにおいているため、適切なクラスに移動させる
  /// 結果表示までじらすための処理
  /// interstitial広告が表示されるために時間を稼ぐという意図もある
  Future<void> waitResult() async {
    final loadingNotifier = ref.read(loadingProvider.notifier);
    loadingNotifier.show();
    await Future<void>.delayed(const Duration(seconds: 3));
    loadingNotifier.hide();
  }

  /// 広告を表示するかどうかを返す
  /// 50%の確率で広告を表示する
  @visibleForTesting
  bool isShownAds() {
    return Random().nextBool();
  }
}
