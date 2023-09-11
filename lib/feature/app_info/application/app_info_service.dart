import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

import '../../../util/constant/strings_constant.dart';
import '../domain/app_info_repository.dart';
import 'app_info_state.dart';

/// appInfoサービスプロバイダー
final appInfoServiceProvider = Provider(AppInfoService.new);

/// アプリ情報関連の処理を行うサービスクラス
class AppInfoService {
  const AppInfoService(this.ref);

  final Ref ref;

  /// アップデートが必要かどうかを返す
  Future<bool> needUpdate() async {
    print('test: start needUpdate()');
    final notifier = ref.read(checkNeedUpdateStateProvider.notifier);
    notifier.state = const AsyncValue.loading();

    final appInfoRepository = ref.read(appInfoRepositoryProvider);

    // アプリのバージョンを取得
    final packageInfo = await PackageInfo.fromPlatform();
    final userAppVersion = Version.parse(packageInfo.version);

    late Version requiredAppVersion;
    notifier.state = await AsyncValue.guard(() async {
      if (Platform.isAndroid) {
        print('test: platform is android');
        requiredAppVersion =
            await appInfoRepository.fetchRequiredAppVersionForAndroid();
      } else {
        requiredAppVersion =
            await appInfoRepository.fetchRequiredAppVersionForIos();
      }
    });

    return userAppVersion < requiredAppVersion;
  }

  /// ストアに遷移する
  Future<void> launchStore() async {
    late Uri launchStoreUrl;
    if (Platform.isAndroid) {
      launchStoreUrl = Uri.parse(playStoreUrl);
    } else {
      launchStoreUrl = Uri.parse(appStoreUrl);
    }

    if (await canLaunchUrl(launchStoreUrl)) {
      await launchUrl(launchStoreUrl, mode: LaunchMode.externalApplication);
      return;
    }
    Exception('Could not send $launchStoreUrl');
  }
}
