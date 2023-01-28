import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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
    } else {
      throw Exception('Could not launch $url');
    }
  }
}
