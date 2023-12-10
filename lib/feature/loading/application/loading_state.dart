import 'package:flutter_riverpod/flutter_riverpod.dart';

// todo notifierProvider
/// ローディング表示しているか否かを返すプロバイダー
final loadingProvider = NotifierProvider<LoadingNotifier, bool>(
  LoadingNotifier.new,
);

class LoadingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  /// ローディングを表示する
  void show() => state = true;

  /// ローディングを非表示にする
  void hide() => state = false;
}
