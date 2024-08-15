import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/router/app_router.dart';
import '../../core/router/navigator_key.dart';
import '../../core/util/extension/context_extension.dart';
import '../component/common/dialog/confirm_dialog.dart';
import '../component/play_quiz_common/incorrect_dialog.dart';
import 'common/navigator_key_controller.dart';

part 'play_normal_quiz_page_controller.freezed.dart';
part 'play_normal_quiz_page_controller.g.dart';

@freezed
class PlayNormalQuizPageState with _$PlayNormalQuizPageState {
  const factory PlayNormalQuizPageState({
    required HitterQuizState normalQuizState,
  }) = _PlayNormalQuizPageState;
}

@riverpod
class PlayNormalQuizPageController extends _$PlayNormalQuizPageController {
  @override
  Future<PlayNormalQuizPageState> build() async {
    final hitterQuizState = await ref.watch(normalQuizStateProvider.future);
    return PlayNormalQuizPageState(normalQuizState: hitterQuizState);
  }

  // * ---------------------- state.hitterQuiz の更新関連 ---------------------- * //
  /// ランダムに1つ成績を公開する
  void _openRandom() {
    final currentValue = state.value!;
    final currentQuizState = currentValue.normalQuizState;

    final newHitterQuizState = currentQuizState.copyWith(
      hitterQuiz: currentQuizState.hitterQuiz.copyWith(
        unveilCount: currentQuizState.hitterQuiz.unveilCount + 1,
      ),
    );
    final newValue = currentValue.copyWith(normalQuizState: newHitterQuizState);

    state = AsyncData(newValue);
  }

  /// 全ての閉じている成績を公開する。
  void _openAll() {
    final currentValue = state.value!;
    final currentQuizState = currentValue.normalQuizState;

    final newHitterQuizState = currentQuizState.copyWith(
      hitterQuiz: currentQuizState.hitterQuiz.copyWith(
        unveilCount: currentQuizState.hitterQuiz.totalStatsCount,
      ),
    );
    final newValue = currentValue.copyWith(normalQuizState: newHitterQuizState);

    state = AsyncData(newValue);
  }

  /// 不正解数を1増やす。
  void _addIncorrectCount() {
    final currentValue = state.value!;
    final currentQuizState = currentValue.normalQuizState;

    final newHitterQuizState = currentQuizState.copyWith(
      hitterQuiz: currentQuizState.hitterQuiz.copyWith(
        incorrectCount: currentQuizState.hitterQuiz.incorrectCount + 1,
      ),
    );
    final newValue = currentValue.copyWith(normalQuizState: newHitterQuizState);

    state = AsyncData(newValue);
  }

  /// enteredHitter を更新する。
  void _updateEnteredHitter(Hitter? enteredHitter) {
    final currentValue = state.value!;
    final currentQuizState = currentValue.normalQuizState;

    final newHitterQuizState =
        currentQuizState.copyWith(enteredHitter: enteredHitter);
    final newValue = currentValue.copyWith(normalQuizState: newHitterQuizState);

    state = AsyncData(newValue);
  }

  // * ---------------------- UI からのイベント ---------------------- * //

  /// 回答を送信する際の処理。
  ///
  /// [hitterName] が null の場合、[ArgumentError] をスローする。
  Future<void> onSubmitAnswer(String? hitterName) async {
    if (hitterName == null) {
      throw ArgumentError.notNull('hitterName');
    }

    // interstitial 広告を作成する。
    await _createInterstitialAd();

    final isCorrect = state.value!.normalQuizState.isCorrectEnteredHitter;
    // * 正解の場合。
    if (isCorrect) {
      final quizState = state.value!.normalQuizState;
      await ref
          .read(quizResultServiceProvider)
          .createNormalQuizResult(quizState);

      ref.invalidate(normalQuizStateProvider);
      ref.invalidateSelf();

      await ref
          .read(appRouterProvider)
          .push(ResultNormalQuizRoute(quizState: quizState));
      return;
    }

    // * 不正解の場合。
    _addIncorrectCount();

    // 広告を確率で表示する。
    await ref.read(interstitialAdServiceProvider).randomShowAd();

    _showIncorrectDialog(hitterName);
  }

  Future<List<Hitter>> onSearchHitter(String inputText) async {
    _updateEnteredHitter(null);

    final seasonType = state.value!.normalQuizState.hitterQuiz.seasonType;
    return ref
        .read(hitterQuizServiceProvider)
        .searchHitter(inputText, seasonType);
  }

  void onSelectedHitter(Hitter? hitter) {
    FocusManager.instance.primaryFocus?.unfocus();
    _updateEnteredHitter(hitter);
  }

  Future<void> onTapShowAllStat() async {
    // 回答入力用の TextField のフォーカスを外す。
    FocusManager.instance.primaryFocus?.unfocus();

    final isAllStatsUnveiled =
        state.value!.normalQuizState.hitterQuiz.isAllStatsUnveiled;
    // 非公開の成績が残っている場合、確認ダイアログを表示する。
    if (isAllStatsUnveiled == false) {
      _showConfirmOpenAllDialog();
    }
  }

  Future<void> onTapShowSingleStat() async {
    // 回答入力用の TextField のフォーカスを外す。
    FocusManager.instance.primaryFocus?.unfocus();

    final isAllStatsUnveiled =
        state.value!.normalQuizState.hitterQuiz.isAllStatsUnveiled;
    // 非公開の成績が残っている場合、ランダムで成績1つ公開する。
    if (isAllStatsUnveiled == false) {
      _openRandom();
    }
  }

  /// 諦めるボタンをタップした際の処理。
  Future<void> onTapRetire() async {
    ref.read(navigatorKeyControllerProvider).showDialogWithChild(
          child: ConfirmDialog(
            confirmText: QuizType.normal.retireConfirmText,
            onAccept: _onAcceptRetire,
          ),
          barrierDismissible: false,
        );
  }

  // * ---------------------- private ---------------------- * //

  /// 諦めることの確認ダイアログで、承認した際の処理。
  Future<void> _onAcceptRetire() async {
    final quizState = state.value!.normalQuizState;
    await ref.read(quizResultServiceProvider).createNormalQuizResult(quizState);

    // ダイアログを閉じる。
    final context = ref.read(navigatorKeyProvider).currentContext!;
    if (context.mounted) {
      context.pop();
    }

    ref.invalidate(normalQuizStateProvider);
    ref.invalidateSelf();

    /// 画面遷移する。
    await ref
        .read(appRouterProvider)
        .push(ResultNormalQuizRoute(quizState: quizState));
  }

  void _showIncorrectDialog(String hitterName) {
    ref.read(navigatorKeyControllerProvider).showDialogWithChild(
          child: IncorrectDialog(
            hitterName: hitterName,
            onTapRetire: onTapRetire,
          ),
          barrierDismissible: false,
        );
  }

  void _showConfirmOpenAllDialog() {
    ref.read(navigatorKeyControllerProvider).showDialogWithChild(
          child: ConfirmDialog(
            confirmText: '本当に全ての成績を表示しますか？',
            onAccept: () {
              _openAll();
              ref.read(navigatorKeyProvider).currentContext!.pop();
            },
          ),
        );
  }

  Future<void> _createInterstitialAd() async {
    final interstitialAdService = ref.read(interstitialAdServiceProvider);

    await interstitialAdService.createAd();
    await interstitialAdService.waitResult();
  }
}
