import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final bannerAdServiceProvider = Provider.autoDispose(
  (_) => BannerAdService(),
);

/// bannerAd関連の処理を行うサービスクラス
class BannerAdService {
  /// バナーIDを取得する
  Future<String> fetchBannerId() async {
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
