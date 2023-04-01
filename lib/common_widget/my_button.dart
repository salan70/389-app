import 'package:flutter/material.dart';

import '../util/constant/button_type_constant.dart';

/// アプリ内で使用するボタン
///
/// メイン、アラート、サブの3種類を定義
///
/// - メインボタンは、画面内で最も重要なボタンに使用。
/// 1画面に1つのみ設置する
///
/// - アラートボタンは、注意が必要な処理を行うボタンに使用。
/// 設置数の制限なしだが、基本的には1画面に1つのとなりそう
///
/// - サブボタンは、メインにもアラートにも該当しないボタンに使用。設置数の制限なし。
class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.buttonType,
    required this.onPressed,
    required this.child,
  });

  final ButtonType buttonType;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: buttonType.buttonStyle,
      onPressed: onPressed,
      child: child,
    );
  }
}
