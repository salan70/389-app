import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _MyButtonState extends ConsumerState<MyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _pressAnim;
  TickerFuture? _downTicker;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _pressAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed == null) {
      return;
    }
    _downTicker = _animController.animateTo(1);
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed == null) {
      return;
    }
    _downTicker?.whenComplete(() {
      // 振動を発生させる。
      HapticFeedback.selectionClick();

      _animController.animateTo(0).whenCompleteOrCancel(() async {
        await ref
            .read(analyticsServiceProvider)
            .logTapButton(widget.buttonName);
        widget.onPressed?.call();
      });
    });
  }

  void _onTapCancel() {
    if (widget.onPressed == null) {
      return;
    }

    _animController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedBuilder(
          animation: _pressAnim,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _pressAnim.value * 4),
              child: child,
            );
          },
          child: TextButton(
            style: widget.buttonType.buttonStyle,
            onPressed: null, // GestureDetector で処理するため、ここでは null.
            child: widget.child,
          ),
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
    final baseStyle = ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
    );

    switch (this) {
      case ButtonType.main:
        return baseStyle.copyWith(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(backgroundColor),
        );

      case ButtonType.alert:
        return baseStyle.copyWith(
          backgroundColor: MaterialStateProperty.all(errorColor),
          foregroundColor: MaterialStateProperty.all(backgroundColor),
        );

      case ButtonType.sub:
        return baseStyle.copyWith(
          side: MaterialStateProperty.all(
            const BorderSide(
              width: 2,
              color: primaryColor,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(primaryColor),
        );

      case ButtonType.disabled:
        return baseStyle.copyWith(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(backgroundColor),
        );
    }
  }
}
