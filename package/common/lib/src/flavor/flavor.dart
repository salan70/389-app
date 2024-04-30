import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flavor.g.dart';

@Riverpod(keepAlive: true)
Flavor flavor(FlavorRef ref) => throw UnimplementedError();

enum Flavor {
  /// 開発環境。
  dev,

  /// 本番環境。
  prod;

  /// 環境変数に応じた [Flavor] を返す。
  static Flavor get fromEnvironment {
    const flavor = String.fromEnvironment('flavor');
    switch (flavor) {
      case 'dev':
        return Flavor.dev;
      case 'prod':
        return Flavor.prod;
      default:
        throw AssertionError('No support flavor');
    }
  }

  /// 環境に応じた interstitial 広告 ID を返す。
  String get interstitialId {
    switch (this) {
      case Flavor.dev:
        return Platform.isAndroid
            ? dotenv.env['TEST_INTERSTITIAL_ID_ANDROID']!
            : dotenv.env['TEST_INTERSTITIAL_ID_IOS']!;
      case Flavor.prod:
        return Platform.isAndroid
            ? dotenv.env['INTERSTITIAL_ID_ANDROID']!
            : dotenv.env['INTERSTITIAL_ID_IOS']!;
    }
  }

  /// 環境に応じた banner 広告 ID を返す。
  String get bannerId {
    switch (this) {
      case Flavor.dev:
        return Platform.isAndroid
            ? dotenv.env['TEST_BANNER_ID_ANDROID']!
            : dotenv.env['TEST_BANNER_ID_IOS']!;
      case Flavor.prod:
        return Platform.isAndroid
            ? dotenv.env['BANNER_ID_ANDROID']!
            : dotenv.env['BANNER_ID_IOS']!;
    }
  }

  /// 環境に応じた reward 広告 ID を返す。
  String get rewardId {
    switch (this) {
      case Flavor.dev:
        return Platform.isAndroid
            ? dotenv.env['TEST_REWARD_ID_ANDROID']!
            : dotenv.env['TEST_REWARD_ID_IOS']!;
      case Flavor.prod:
        return Platform.isAndroid
            ? dotenv.env['REWARD_ID_ANDROID']!
            : dotenv.env['REWARD_ID_IOS']!;
    }
  }
}
