import 'package:flutter/material.dart';

import '../util/constant/colors_constant.dart';

/// アプリ内で使用するボタン
///
/// isMainがtrueの場合はメインボタンとして使用する
///
/// メインボタンは、画面内で最も重要なボタンに使用するため、
/// 1画面に1つのみ設置する
///
/// メインでない（サブ）ボタンは、設置数に制限なし
class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.isMain,
    required this.onPressed,
    required this.child,
  });

  final bool isMain;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mainButtonStyle = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: primaryColor,
      foregroundColor: backgroundColor,
    );

    final subButtonStyle = TextButton.styleFrom(
      side: const BorderSide(
        width: 2,
        color: primaryColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: backgroundColor,
      foregroundColor: primaryColor,
    );

    return TextButton(
      style: isMain ? mainButtonStyle : subButtonStyle,
      onPressed: onPressed,
      child: child,
    );
  }
}
