import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/constant/inquiry.dart';

final urlLauncherServiceProvider = Provider.autoDispose(
  (_) => UrlLauncherService(),
);

/// URL起動を行うサービスクラス
class UrlLauncherService {
  /// メールアプリを起動する
  Future<void> launchMail(String subject, String body) async {
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

  /// 外部ブラウザを起動する
  Future<void> launchBrowser(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }
    throw Exception('Could not launch $url');
  }
}
