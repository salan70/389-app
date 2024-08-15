import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loading_notifier.g.dart';

@riverpod
class LoadingNotifier extends _$LoadingNotifier {
  @override
  bool build() => false;

  /// ローディングを表示する。
  void show() => state = true;

  /// ローディングを非表示にする。
  void hide() => state = false;
}
