import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:version/version.dart';

final appInfoRepositoryProvider = Provider<AppInfoRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class AppInfoRepository {
  /// iOSでプレイするのに必要なアプリバージョンを取得する
  Future<Version> fetchRequiredAppVersionForIos();

  /// Androidでプレイするのに必要なアプリバージョンを取得する
  Future<Version> fetchRequiredAppVersionForAndroid();
}
