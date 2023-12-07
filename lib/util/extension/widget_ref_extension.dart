import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widget/error_dialog.dart';
import '../../feature/loading/application/loading_state.dart';

/// ダイアログ表示用のGlobalKeyを返す
/// .currentContext!でcontextを取得できる
final navigatorKeyProvider = Provider(
  (_) => GlobalKey<NavigatorState>(),
);

/// ref.listen() を共通化して使い回せるようにするためのextension
/// 参考
/// https://zenn.dev/susatthi/articles/20221214-090833-flutter-async-value#%E5%85%B1%E9%80%9A%E5%8C%96%EF%BC%81
extension WidgetRefEx on WidgetRef {
  /// AsyncValueを良しなにハンドリングする
  void handleAsyncValue<T>(
    ProviderListenable<AsyncValue<T>> asyncValueProvider,
  ) =>
      listen<AsyncValue<T>>(
        asyncValueProvider,
        (_, next) async {
          final loadingNotifier = read(loadingProvider.notifier);
          if (next.isLoading) {
            loadingNotifier.show();
            return;
          }

          next.when(
            data: (_) async {
              loadingNotifier.hide();
            },
            error: (e, _) async {
              loadingNotifier.hide();

              // エラーダイアログを表示
              await showDialog<void>(
                context: read(navigatorKeyProvider).currentContext!,
                builder: (context) => ErrorDialog(error: e),
              );
            },
            loading: loadingNotifier.show,
          );
        },
      );
}
