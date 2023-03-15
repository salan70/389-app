import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final urlLauncherServiceProvider = Provider.autoDispose(
  (_) => UrlLauncherService(),
);

/// URL起動を行うサービスクラス
class UrlLauncherService {
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
