import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../common_widget/dialog/error_dialog.dart';
import '../router/scaffold_messenger_key.dart';

/// Controller で使用する Mixin.
mixin ControllerMixin {
  /// オーバーレイローディングを伴い、
  /// エラー発生時に ErrorDialog を表示する処理を実行する。
  ///
  /// エラーが発生せずにローディング完了した際に、
  /// 処理を実行したい場合は、 [onLoadingComplete] に渡す。
  Future<void> executeWithOverlayLoading(
    Ref ref, {
    required Future<void> Function() action,
    VoidCallback? onLoadingComplete,
  }) async {
    ref.read(loadingNotifierProvider.notifier).show();

    try {
      await action();
      ref.read(loadingNotifierProvider.notifier).hide();
      onLoadingComplete?.call();
    } on Exception catch (e, s) {
      logger.e('error: $e, stackTrace: $s');
      ref.read(loadingNotifierProvider.notifier).hide();

      // エラーダイアログを表示
      await showDialog<void>(
        context: ref.read(scaffoldMessengerKeyProvider).currentContext!,
        builder: (context) => const ErrorDialog(),
      );
    }
  }
}
