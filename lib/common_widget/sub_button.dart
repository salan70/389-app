import 'package:flutter/material.dart';

import '../util/constant/colors_constant.dart';

/// 重要でないボタンに使用する枠線で囲まれたボタン
/// 設置数に制限はない
class SubButton extends StatelessWidget {
  const SubButton({super.key, required this.onPressed, required this.child});

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        side: const BorderSide(
          width: 2,
          color: primaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: primaryColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
