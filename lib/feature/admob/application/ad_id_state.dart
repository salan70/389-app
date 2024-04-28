import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ad_id_state.g.dart';

@riverpod
Future<String> bannerAdId(BannerAdIdRef ref) async {
  final packageInfo = await PackageInfo.fromPlatform();
  final appName = packageInfo.appName;

  // prod 環境の場合
  if (appName == '.389') {
    return Platform.isAndroid
        ? dotenv.env['BANNER_ID_ANDROID']!
        : dotenv.env['BANNER_ID_IOS']!;
  }

  // prod 環境以外の場合
  return Platform.isAndroid
      ? dotenv.env['TEST_BANNER_ID_ANDROID']!
      : dotenv.env['TEST_BANNER_ID_IOS']!;
}

@riverpod
Future<String> rewardAdId(RewardAdIdRef ref) async {
  final packageInfo = await PackageInfo.fromPlatform();
  final appName = packageInfo.appName;

  // prod 環境の場合
  if (appName == '.389') {
    return Platform.isAndroid
        ? dotenv.env['REWARD_ID_ANDROID']!
        : dotenv.env['REWARD_ID_IOS']!;
  }

  // prod 環境以外の場合
  return Platform.isAndroid
      ? dotenv.env['TEST_REWARD_ID_ANDROID']!
      : dotenv.env['TEST_REWARD_ID_IOS']!;
}
