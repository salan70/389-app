import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/loading/loading_state.dart';

final playQuizViewModelProvider =
    Provider<PlayQuizViewModel>(PlayQuizViewModel.new);

class PlayQuizViewModel {
  PlayQuizViewModel(
    this.ref,
  );

  final Ref ref;

  /// 結果表示までじらすための処理
  /// interstitial広告が表示されるために時間を稼ぐという意図もある
  Future<void> waitResult() async {
    final loadingNotifier = ref.read(loadingProvider.notifier);
    loadingNotifier.show();
    await Future<void>.delayed(const Duration(seconds: 3));
    loadingNotifier.hide();
  }

  /// 広告を表示するかどうかを返す
  /// 50%の確率で広告を表示する
  bool isShownAds() {
    return Random().nextBool();
  }
}
