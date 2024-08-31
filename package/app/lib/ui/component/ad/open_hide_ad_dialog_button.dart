import 'package:flutter/material.dart';

import '../common/button/my_button.dart';

class OpenHideAdDialogButton extends StatelessWidget {
  const OpenHideAdDialogButton({
    super.key,
    required this.buttonWidth,
  });

  final double buttonWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      child: const MyButton(
        buttonName: 'open_hide_ad_dialog_button',
        buttonType: ButtonType.sub,
        onPressed: null,
        child: Icon(Icons.app_blocking_rounded),
      ),
    );
  }
}
