import 'package:flutter/material.dart';

import '../common/button/my_button.dart';

class OpenHideAdDialogButton extends StatelessWidget {
  const OpenHideAdDialogButton({
    super.key,
    required this.buttonWidth,
    required this.onTap,
  });

  final double buttonWidth;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      child: MyButton(
        buttonName: 'open_hide_ad_dialog_button',
        buttonType: ButtonType.sub,
        onPressed: onTap,
        child: const Icon(Icons.app_blocking_rounded),
      ),
    );
  }
}
