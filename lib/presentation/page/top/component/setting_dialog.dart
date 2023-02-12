import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/inquiry/inquiry_service.dart';
import '../../../../application/web_to/web_to_service.dart';
import '../../../../util/constant/url.dart';

class SettingDialog extends ConsumerWidget {
  const SettingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inquiryService = ref.watch(inquiryServiceProvider);
    final webToService = ref.watch(webToServiceProvider);

    return Dialog(
      child: SingleChildScrollView(
        child: SizedBox(
          height: 320,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text('その他'),
              const SizedBox(
                height: 24,
              ),
              TextButton.icon(
                onPressed: inquiryService.sendInquiry,
                icon: const Icon(Icons.mail_outline_rounded),
                label: const Text('お問い合わせ'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton.icon(
                onPressed: () {
                  webToService.launchUrlInBrowser(termsUrl);
                },
                icon: const Icon(Icons.description_rounded),
                label: const Text('利用規約'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton.icon(
                onPressed: () {
                  webToService.launchUrlInBrowser(privacyPolicyUrl);
                },
                icon: const Icon(Icons.person_rounded),
                label: const Text('プライバシーポリシー'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close_rounded),
                label: const Text('閉じる'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
