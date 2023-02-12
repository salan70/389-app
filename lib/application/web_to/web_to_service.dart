import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final webToServiceProvider = Provider.autoDispose((_) => WebToService());

/// 外部Webブラウザへ遷移する処理を行うサービスクラス
class WebToService {
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
}
