import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constant/inquiry.dart';
import '../../../../repository/auth_repository.dart';

final settingDialogViewModelProvider =
    Provider.autoDispose<SettingDialogViewModel>(SettingDialogViewModel.new);

class SettingDialogViewModel {
  SettingDialogViewModel(
    this.ref,
  );

  final Ref ref;

  Future<void> launchUrlInBrowser(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      return;
    }
    throw Exception('Could not launch $url');
  }

  // お問い合わせを送る
  Future<void> sendInquiry() async {
    // TODO(me): この処理関数として抽出したい
    // 端末関連の情報を取得
    final deviceInfo = DeviceInfoPlugin();
    late String os;
    late String? osVersion;
    late String? device;
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      os = 'iOS';
      osVersion = iosInfo.systemVersion;
      device = iosInfo.model;
    } else {
      final androidInfo = await deviceInfo.androidInfo;
      os = 'Android';
      osVersion = androidInfo.version.release;
      device = androidInfo.model;
    }

    // アプリのバージョンを取得
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = packageInfo.version;

    // ユーザーIDを取得
    final uid = ref.read(authRepositoryProvider).getCurrentUser()?.uid;

    const subject = '【タイトルをご記載ください】 /.389';
    final body = 'こちらにお問い合わせ内容をご記載ください\n\n\n\n\n'
        '\n※調査のため、以下の情報は消さないようお願いします。'
        '$device, $os, $osVersion, $appVersion, $uid';

    final uri = Uri(
      scheme: 'mailto',
      path: mailAddress, // お問い合わせ先
      query: _encodeQueryParameters(<String, String>{
        'subject': subject,
        'body': body,
      }),
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      return;
    }
    Exception('Could not send inquiry');
  }

  // TODO(me): テスト書く
  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }
}
