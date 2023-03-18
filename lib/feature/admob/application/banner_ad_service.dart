import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../util/logger.dart';

final bannerAdServiceProvider = Provider.autoDispose(
  (_) => BannerAdService(),
);

/// BannerAd関連の処理を行うサービスクラス
///
/// Widgetを返しており、application層には不適切かもしれない。。
// TODO(me): presentation層への移動などを検討する
class BannerAdService {
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
