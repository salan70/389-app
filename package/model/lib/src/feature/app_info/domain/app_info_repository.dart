import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:version/version.dart';

part 'app_info_repository.g.dart';

@riverpod
AppInfoRepository appInfoRepository(AppInfoRepositoryRef ref) =>
    throw UnimplementedError('Provider was not initialized');

abstract class AppInfoRepository {
  /// iOSでプレイするのに必要なアプリバージョンを取得する
  Future<Version> fetchRequiredAppVersionForIos();

  /// Androidでプレイするのに必要なアプリバージョンを取得する
  Future<Version> fetchRequiredAppVersionForAndroid();
}
