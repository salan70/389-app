import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widget/my_button.dart';
import '../../../util/constant/button_type_constant.dart';
import '../application/inquiry_service.dart';

class InquiryButton extends ConsumerWidget {
  const InquiryButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inquiryService = ref.watch(inquiryServiceProvider);

    return MyButton(
      buttonType: ButtonType.sub,
      onPressed: () async {
        final body = await inquiryService.createInquiryBody();
        await inquiryService.launchMail(body);
      },
      child: Stack(
        children: const [
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
