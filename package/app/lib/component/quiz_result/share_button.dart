import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common_widget/button/my_button.dart';

class ShareButton extends ConsumerWidget {
  const ShareButton({
    super.key,
    required this.buttonType,
    required this.onPressed,
  });

  final ButtonType buttonType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'share_button',
      buttonType: buttonType,
      onPressed: onPressed,
      child: const Text('クイズをシェア！'),
    );
  }
}
