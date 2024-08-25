import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'consecutive_ad_count_notifier.g.dart';

/// 連続してインタースティシャル広告を表示する回数を管理する [Notifier].
///
/// 問題が変わっても回数を引き継ぐ（リセットしない）ため、`keepAlive` を `true` にしている。
@Riverpod(keepAlive: true)
class ConsecutiveAdCountNotifier extends _$ConsecutiveAdCountNotifier {
  @override
  int build() {
    return 0;
  }

  static const int maxConsecutiveAdCount = 2;

  void increment() {
    if (state < maxConsecutiveAdCount) {
      state = state + 1;
    }
  }

  void reset() {
    state = 0;
  }

  bool canShowAd() => state < maxConsecutiveAdCount;
}
