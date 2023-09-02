import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/my_button.dart';
import '../../../../util/constant/button_type_constant.dart';
import '../../application/share_quiz_result_service.dart';

class ShareButton extends ConsumerWidget {
  const ShareButton({
    super.key,
    required this.buttonType,
    required this.globalKey,
    required this.shareText,
  });

  final ButtonType buttonType;
  final GlobalKey globalKey;
  final String shareText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonType: buttonType,
      onPressed: () {
        ref.read(shareQuizResultServiceProvider).shareImageAndText(
              'result_quiz_widget',
              globalKey,
              shareText,
            );
      },
      child: const Text('クイズをシェア！'),
    );
  }
}
