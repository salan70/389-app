import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/router/navigator_key.dart';

part 'navigator_key_controller.g.dart';

@riverpod
NavigatorKeyController navigatorKeyController(NavigatorKeyControllerRef ref) {
  final key = ref.watch(navigatorKeyProvider);
  return NavigatorKeyController(key);
}

class NavigatorKeyController {
  NavigatorKeyController(this._navigatorKey);

  final GlobalKey<NavigatorState> _navigatorKey;

  /// [child] をダイアログとして表示する。
  void showDialogWithChild({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    showDialog<void>(
      context: _navigatorKey.currentContext!,
      useRootNavigator: false,
      barrierDismissible: barrierDismissible,
      builder: (context) => child,
    );
  }
}
