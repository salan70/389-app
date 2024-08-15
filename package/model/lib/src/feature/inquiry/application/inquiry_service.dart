import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../util/constant/strings_constant.dart';
import '../../auth/infrastructure/auth_repository.dart';

part 'inquiry_service.g.dart';

@riverpod
InquiryService inquiryService(InquiryServiceRef ref) => InquiryService(ref);

/// お問い合わせ関連の処理を行うサービスクラス
class InquiryService {
  InquiryService(this.ref);

  final Ref ref;

  /// メールアプリを起動する
  Future<void> launchMail(String body) async {
    final uri = Uri(
      scheme: 'mailto',
      path: mailAddress,
      queryParameters: {'subject': subject, 'body': body},
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }
    Exception('Could not send inquiry');
  }

  /// お問い合わせメールの本文を作成する
  Future<String> createInquiryBody() async {
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

    // uidをユーザー側に知られるのはリスクがありそうなため、
    // uidの一部を抜粋したものをidとする
    final id =
        ref.read(authRepositoryProvider).getCurrentUser()?.uid.substring(5, 14);

    return 'こちらにお問い合わせ内容をご記載ください\n\n\n\n\n'
        '\n※調査のため、以下の情報は消さないようお願いします。'
        '$device, $os, $osVersion, $appVersion, $id';
  }
}
