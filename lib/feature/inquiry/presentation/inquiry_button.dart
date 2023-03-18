import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/inquiry_service.dart';

class InquiryButton extends ConsumerWidget {
  const InquiryButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inquiryService = ref.watch(inquiryServiceProvider);

    return TextButton.icon(
      onPressed: () async {
        final body = await inquiryService.createInquiryBody();
        await inquiryService.launchMail(body);
      },
      icon: const Icon(Icons.mail_outline_rounded),
      label: const Text('お問い合わせ'),
    );
  }
}
