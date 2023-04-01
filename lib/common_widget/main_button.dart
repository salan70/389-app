import 'package:flutter/material.dart';

import '../util/constant/colors_constant.dart';

/// 重要なボタンに使用する色付きのボタン
/// 1画面につき1つのみ設置することを想定している。
class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.onPressed, required this.child});

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: primaryColor,
        foregroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
