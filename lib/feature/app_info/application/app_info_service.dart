import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../util/constant/strings_constant.dart';

part 'app_info_service.g.dart';

@riverpod
AppInfoService appInfoService(AppInfoServiceRef ref) => AppInfoService(ref);

/// アプリ情報関連の処理を行うサービスクラス
class AppInfoService {
  const AppInfoService(this.ref);

  final Ref ref;

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
