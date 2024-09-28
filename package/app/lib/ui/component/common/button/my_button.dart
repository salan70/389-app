import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../../core/util/colors_constant.dart';

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
class MyButton extends ConsumerStatefulWidget {
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
  ConsumerState<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends ConsumerState<MyButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.translationValues(0, _isPressed ? 4 : 0, 0),
        curve: Curves.easeInOut,
        child: TextButton(
          style: widget.buttonType.buttonStyle,
          onPressed: widget.buttonType == ButtonType.disabled
              ? null
              : () async {
                  await ref
                      .read(analyticsServiceProvider)
                      .logTapButton(widget.buttonName);
                  widget.onPressed?.call();
                },
          child: widget.child,
        ),
      ),
    );
  }
}

// TODO(me): MyButton の factory コンストラクタでボタンを指定したほうが良さそう。
enum ButtonType {
  main,
  alert,
  sub,
  disabled;

  ButtonStyle get buttonStyle {
    switch (this) {
      case ButtonType.main:
        return ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(backgroundColor),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
        );

      case ButtonType.alert:
        return ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(errorColor),
          foregroundColor: MaterialStateProperty.all(backgroundColor),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
        );

      case ButtonType.sub:
        return ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          side: MaterialStateProperty.all(
            const BorderSide(
              width: 2,
              color: primaryColor,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(primaryColor),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
        );

      case ButtonType.disabled:
        return ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(backgroundColor),
          splashFactory: NoSplash.splashFactory,
        );
    }
  }
}
