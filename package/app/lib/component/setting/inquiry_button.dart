import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/button/my_button.dart';

class InquiryButton extends ConsumerWidget {
  const InquiryButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inquiryService = ref.watch(inquiryServiceProvider);

    return MyButton(
      buttonName: 'to_inquiry_button',
      buttonType: ButtonType.sub,
      onPressed: () async {
        final body = await inquiryService.createInquiryBody();
        await inquiryService.launchMail(body);
      },
      child: const Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.mail_outline_rounded),
          ),
          Center(child: Text('お問い合わせ')),
        ],
      ),
    );
  }
}
