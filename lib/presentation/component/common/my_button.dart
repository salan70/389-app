import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature/analytics/application/analytics_service.dart';
import '../../../util/constant/colors_constant.dart';



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
class MyButton extends ConsumerWidget {
  const MyButton({
    super.key,
    required this.buttonName,
    required this.buttonType,
    required this.onPressed,
    required this.child,
  });

  /// Analytics に送信する用のボタンの名称。
  ///
  /// スネークケースのアルファベットで記述する。
  final String buttonName;
  final ButtonType buttonType;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      style: buttonType.buttonStyle,
      onPressed: () async {
        await ref.read(analyticsServiceProvider).logTapButton(buttonName);
        onPressed?.call();
      },
      child: child,
    );
  }
}

// TODO(me): MyButton の factory コンストラクタでボタンを指定したほうが良さそう。
enum ButtonType {
  main,
  alert,
  sub;

  ButtonStyle get buttonStyle {
    switch (this) {
      case ButtonType.main:
        return TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: primaryColor,
          disabledBackgroundColor: primaryColor.withOpacity(0.4),
          foregroundColor: backgroundColor,
        );

      case ButtonType.alert:
        return TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: errorColor,
          foregroundColor: backgroundColor,
        );
      case ButtonType.sub:
        return TextButton.styleFrom(
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
    }
  }
}
