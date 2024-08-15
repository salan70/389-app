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

part 'play_daily_quiz_page_controller.freezed.dart';
part 'play_daily_quiz_page_controller.g.dart';

@freezed
class PlayDailyQuizPageState with _$PlayDailyQuizPageState {
  const factory PlayDailyQuizPageState({
    required HitterQuizState quizState,

    /// 回答が未入力の旨のエラーメッセージを表示するかどうか。
    required bool showNotEnteredError,
  }) = _PlayDailyQuizPageState;
}

@riverpod
class PlayDailyQuizPageController extends _$PlayDailyQuizPageController {
  @override
  Future<PlayDailyQuizPageState> build(DateTime questionedAt) async {
    final dailyQuiz = await ref.watch(dailyQuizProvider(questionedAt).future);
    if (dailyQuiz == null) {
      // TODO(me): Exception をスローするべき？
      throw ArgumentError.notNull('dailyQuiz');
    }

    final hitterQuizState = await ref
        .watch(hitterRepositoryProvider)
        .fetchInputDailyQuizState(dailyQuiz);

    return PlayDailyQuizPageState(
      quizState: hitterQuizState,
      showNotEnteredError: false,
    );
  }

  // * ---------------------- state.hitterQuiz の更新関連 ---------------------- * //
  /// ランダムに1つ成績を公開する。
  void _openRandom() {
    final currentValue = state.value!;
    final currentQuizState = currentValue.quizState;

    final newHitterQuizState = currentQuizState.copyWith(
      hitterQuiz: currentQuizState.hitterQuiz.copyWith(
        unveilCount: currentQuizState.hitterQuiz.unveilCount + 1,
      ),
    );
    final newValue = currentValue.copyWith(quizState: newHitterQuizState);

    state = AsyncData(newValue);
  }

  /// 全ての閉じている成績を公開する。
  void _openAll() {
    final currentValue = state.value!;
    final currentQuizState = currentValue.quizState;

    final newHitterQuizState = currentQuizState.copyWith(
      hitterQuiz: currentQuizState.hitterQuiz.copyWith(
        unveilCount: currentQuizState.hitterQuiz.totalStatsCount,
      ),
    );
    final newValue = currentValue.copyWith(quizState: newHitterQuizState);

    state = AsyncData(newValue);
  }

  /// 不正解数を1増やす。
  void _addIncorrectCount() {
    final currentValue = state.value!;
    final currentQuizState = currentValue.quizState;

    final newHitterQuizState = currentQuizState.copyWith(
      hitterQuiz: currentQuizState.hitterQuiz.copyWith(
        incorrectCount: currentQuizState.hitterQuiz.incorrectCount + 1,
      ),
    );
    final newValue = currentValue.copyWith(quizState: newHitterQuizState);

    state = AsyncData(newValue);
  }

  /// enteredHitter を更新する。
  void _updateEnteredHitter(Hitter? enteredHitter) {
    final currentValue = state.value!;
    final currentQuizState = currentValue.quizState;

    final newHitterQuizState =
        currentQuizState.copyWith(enteredHitter: enteredHitter);
    final newValue = currentValue.copyWith(quizState: newHitterQuizState);

    state = AsyncData(newValue);
  }

  // * ---------------------- UI からのイベント ---------------------- * //

  /// 今日の1問の回答を送信する際の処理。
  ///
  /// [hitterName] が null の場合、入力を促すエラーを表示する。
  Future<void> onTapSubmitAnswer(String? hitterName) async {
    if (hitterName == null) {
      state = AsyncData(state.value!.copyWith(showNotEnteredError: true));
      return;
    }

    // 間違えれる回数が上限に達している（最後の回答を送信している）場合、
    // 確認ダイアログを表示する
    if (_isFinalAnswer) {
      _showConfirmLastSubmitDialog(hitterName, questionedAt);
      return;
    }

    await _submitAnswer(hitterName);
  }

  Future<void> onTapShowAllStat() async {
    // 回答入力用の TextField のフォーカスを外す。
    FocusManager.instance.primaryFocus?.unfocus();

    final isAllStatsUnveiled =
        state.value!.quizState.hitterQuiz.isAllStatsUnveiled;
    // 非公開の成績が残っている場合、確認ダイアログを表示する。
    if (isAllStatsUnveiled == false) {
      _showConfirmOpenAllDialog();
    }
  }

  Future<void> onTapShowSingleStat() async {
    // 回答入力用の TextField のフォーカスを外す。
    FocusManager.instance.primaryFocus?.unfocus();

    final isAllStatsUnveiled =
        state.value!.quizState.hitterQuiz.isAllStatsUnveiled;
    // 非公開の成績が残っている場合、確認ダイアログを表示する。
    if (isAllStatsUnveiled == false) {
      _openRandom();
    }
  }

  Future<List<Hitter>> onSearchHitter(String inputText) async {
    _updateEnteredHitter(null);

    final seasonType = state.value!.quizState.hitterQuiz.seasonType;
    return ref
        .read(hitterQuizServiceProvider)
        .searchHitter(inputText, seasonType);
  }

  void onSelectedHitter(Hitter value) {
    // 回答入力用のTextFieldのフォーカスを外す
    FocusManager.instance.primaryFocus?.unfocus();
    // エラーメッセージを非表示にする。
    state = AsyncData(state.value!.copyWith(showNotEnteredError: false));

    _updateEnteredHitter(value);
  }

  /// 諦めるボタンをタップした際の処理。
  Future<void> onTapRetire() async {
    ref.read(navigatorKeyControllerProvider).showDialogWithChild(
          child: ConfirmDialog(
            confirmText: QuizType.daily.retireConfirmText,
            onAccept: _onAcceptRetire,
          ),
          barrierDismissible: false,
        );
  }

  // * ---------------------- private ---------------------- * //

  /// 最終回答時の確認ダイアログを表示する。
  ///
  /// このダイアログで回答することを承認した場合、二度と [questionedAt] の今日の1問に回答できない。
  void _showConfirmLastSubmitDialog(String hitterName, DateTime questionedAt) {
    ref.read(navigatorKeyControllerProvider).showDialogWithChild(
          child: ConfirmDialog(
            confirmText: 'これが最後のチャンスです。\n本当にその回答でよろしいですか？',
            onAccept: () async => _submitAnswer(hitterName),
          ),
          barrierDismissible: false,
        );
  }

  /// 今日の1問をリタイアする際の処理。
  Future<void> _onAcceptRetire() async => _finishQuiz();

  void _showConfirmOpenAllDialog() {
    ref.read(navigatorKeyControllerProvider).showDialogWithChild(
          child: ConfirmDialog(
            confirmText: '本当に全ての成績を表示しますか？',
            onAccept: _openAll,
          ),
        );
  }

  Future<void> _submitAnswer(String hitterName) async {
    // interstitial 広告を作成する。
    await _createInterstitialAd();

    // * 正解の場合
    final isCorrect = state.value!.quizState.isCorrectEnteredHitter;
    if (isCorrect) {
      await _finishQuiz();
      return;
    }

    // * 不正解の場合
    _addIncorrectCount();

    // interstitial 広告を確率で表示する。
    await ref.read(interstitialAdServiceProvider).randomShowAd();

    // ** 最後の回答の場合
    if (_isFinalAnswer) {
      await _finishQuiz();
      return;
    }

    // ** 最後の回答でない場合
    _showIncorrectDialog(hitterName);
  }

  Future<void> _createInterstitialAd() async {
    final interstitialAdService = ref.read(interstitialAdServiceProvider);

    await interstitialAdService.createAd();
    await interstitialAdService.waitResult();
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

  /// クイズ終了（最終回答）時の処理。
  ///
  /// dailyQuizResult を更新し、結果ページに遷移する。
  Future<void> _finishQuiz() async {
    final quizState = state.value!.quizState;
    await ref
        .read(quizResultServiceProvider)
        .updateDailyQuizResult(questionedAt, quizState);

    // ダイアログを閉じる。
    final context = ref.read(navigatorKeyProvider).currentContext!;
    if (context.mounted) {
      context.pop();
    }

    ref.invalidateSelf();

    /// 画面遷移する。
    await ref
        .read(appRouterProvider)
        .push(ResultDailyQuizRoute(quizState: quizState));
  }

  bool get _isFinalAnswer {
    // 最大で回答できる数。
    const maxCanAnswerCount = 3;

    return state.value!.quizState.hitterQuiz.incorrectCount ==
        maxCanAnswerCount;
  }
}
