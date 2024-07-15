import 'dart:math';

import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../loading/application/loading_notifier.dart';

part 'interstitial_ad_service.g.dart';

// provide が再生成されると、 _interstitialAd が null になるため、 keepAlive を true にしている。
@Riverpod(keepAlive: true)
InterstitialAdService interstitialAdService(InterstitialAdServiceRef ref) =>
    InterstitialAdService(ref);

/// Interstitial 広告関連の処理を行うサービスクラス。
class InterstitialAdService {
  InterstitialAdService(this.ref);

  final Ref ref;
  InterstitialAd? _interstitialAd;

  /// 広告を作成する。
  Future<void> createAd() async {
    await InterstitialAd.load(
      adUnitId: ref.read(flavorProvider).interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: logger.e,
      ),
    );
  }

  /// 広告を表示する。
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

  /// ランダムで広告を表示する。
  Future<void> randomShowAd() async {
    if (isShownAds()) {
      await showAd();
    }
  }

  // TODO(me): 仮置でここのクラスにおいているため、適切なクラスに移動させる。
  /// 結果表示までじらすための処理。
  /// interstitial 広告が表示されるために時間を稼ぐという意図もある。
  Future<void> waitResult() async {
    final loadingNotifier = ref.read(loadingNotifierProvider.notifier);
    loadingNotifier.show();
    await Future<void>.delayed(const Duration(seconds: 2));
    loadingNotifier.hide();
  }

  /// 広告を表示するかどうかを返す。
  ///
  /// 70%の確率で広告を表示する。
  @visibleForTesting
  bool isShownAds() {
    final randomInt = Random().nextInt(100);
    return randomInt < 70;
  }
}
