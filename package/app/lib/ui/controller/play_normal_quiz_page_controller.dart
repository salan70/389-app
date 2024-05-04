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
    required HitterQuizState hitterQuiz,
  }) = _PlayNormalQuizPageState;
}

@riverpod
class PlayNormalQuizPageController extends _$PlayNormalQuizPageController {
  @override
  Future<PlayNormalQuizPageState> build() async {
    final searchCondition = ref.watch(searchConditionProvider);
    final hitterQuiz = await ref
        .watch(hitterRepositoryProvider)
        .fetchHitterQuizBySearchCondition(searchCondition);

    return PlayNormalQuizPageState(hitterQuiz: hitterQuiz);
  }

  // * ---------------------- state.hitterQuiz の更新関連 ---------------------- * //
  /// ランダムに1つ成績を公開する
  void _openRandom() {
    final value = state.value!;
    state = AsyncData(
      value.copyWith(
        hitterQuiz: value.hitterQuiz.copyWith(
          unveilCount: value.hitterQuiz.unveilCount + 1,
        ),
      ),
    );
  }

  /// 全ての閉じている成績を公開する。
  void _openAll() {
    final value = state.value!;
    state = AsyncData(
      value.copyWith(
        hitterQuiz: value.hitterQuiz.copyWith(
          unveilCount: value.hitterQuiz.totalStatsCount,
        ),
      ),
    );
  }

  /// isCorrect を true にする。
  void _markCorrect() {
    state = AsyncData(
      state.value!.copyWith(
        hitterQuiz: state.value!.hitterQuiz.copyWith(isCorrect: true),
      ),
    );
  }

  /// 不正解数を1増やす。
  void _addIncorrectCount() {
    final value = state.value!;
    state = AsyncData(
      value.copyWith(
        hitterQuiz: value.hitterQuiz.copyWith(
          incorrectCount: value.hitterQuiz.incorrectCount + 1,
        ),
      ),
    );
  }

  /// enteredHitter を更新する。
  void _updateEnteredHitter(Hitter? enteredHitter) {
    state = AsyncData(
      state.value!.copyWith(
        hitterQuiz:
            state.value!.hitterQuiz.copyWith(enteredHitter: enteredHitter),
      ),
    );
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

    final isCorrect = state.value!.hitterQuiz.isCorrectEnteredHitter;
    // * 正解の場合。
    if (isCorrect) {
      _markCorrect();
      final hitterQuizState = state.value!.hitterQuiz;
      await ref
          .read(quizResultServiceProvider)
          .createNormalQuizResult(hitterQuizState);

      ref.invalidateSelf();

      await ref.read(appRouterProvider).push(
            ResultNormalQuizRoute(hitterQuizState: hitterQuizState),
          );
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
    return ref.read(hitterQuizServiceProvider).searchHitter(inputText);
  }

  void onSelectedHitter(Hitter? hitter) {
    FocusManager.instance.primaryFocus?.unfocus();
    _updateEnteredHitter(hitter);
  }

  Future<void> onTapShowAllStat() async {
    // 回答入力用の TextField のフォーカスを外す。
    FocusManager.instance.primaryFocus?.unfocus();

    final isAllStatsUnveiled = state.value!.hitterQuiz.isAllStatsUnveiled;
    // 非公開の成績が残っている場合、確認ダイアログを表示する。
    if (isAllStatsUnveiled == false) {
      _showConfirmOpenAllDialog();
    }
  }

  Future<void> onTapShowSingleStat() async {
    // 回答入力用の TextField のフォーカスを外す。
    FocusManager.instance.primaryFocus?.unfocus();

    final isAllStatsUnveiled = state.value!.hitterQuiz.isAllStatsUnveiled;
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
            onPressedYes: _onAcceptRetire,
          ),
          barrierDismissible: false,
        );
  }

  // * ---------------------- private ---------------------- * //

  /// 諦めることの確認ダイアログで、承認した際の処理。
  Future<void> _onAcceptRetire() async {
    await ref
        .read(quizResultServiceProvider)
        .createNormalQuizResult(state.value!.hitterQuiz);

    // ダイアログを閉じる。
    final context = ref.read(navigatorKeyProvider).currentContext!;
    if (context.mounted) {
      context.pop();
    }

    ref.invalidateSelf();

    /// 画面遷移する。
    await ref
        .read(appRouterProvider)
        .push(ResultNormalQuizRoute(hitterQuizState: state.value!.hitterQuiz));
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
            onPressedYes: () {
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
