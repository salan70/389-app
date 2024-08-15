import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'browser_service.g.dart';

@riverpod
BrowserService browserService(BrowserServiceRef ref) => BrowserService();

/// ブラウザ起動を行うサービスクラス
class BrowserService {
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
