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
    required HitterQuizState hitterQuiz,
  }) = _PlayDailyQuizPageState;
}

@riverpod
class PlayDailyQuizPageController extends _$PlayDailyQuizPageController {
  @override
  Future<PlayDailyQuizPageState> build(DateTime questionedAt) async {
    final dailyQuiz = await ref.watch(dailyQuizProvider(questionedAt).future);
    if (dailyQuiz == null) {
      throw ArgumentError.notNull('dailyQuiz');
    }

    final hitterQuiz = await ref
        .watch(hitterRepositoryProvider)
        .fetchHitterQuizById(dailyQuiz);

    return PlayDailyQuizPageState(hitterQuiz: hitterQuiz);
  }

  static const _maxCanIncorrectCount = 2;

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

  /// 今日の1問の回答を送信する際の処理。
  ///
  /// [hitterName] が null の場合、[ArgumentError] をスローする。
  Future<void> onTapSubmitAnswer(String? hitterName) async {
    if (hitterName == null) {
      throw ArgumentError.notNull('hitterName');
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
    // 非公開の成績が残っている場合、確認ダイアログを表示する。
    if (isAllStatsUnveiled == false) {
      _openRandom();
    }
  }

  Future<List<Hitter>> onSearchHitter(String inputText) async {
    _updateEnteredHitter(null);
    return ref.read(hitterQuizServiceProvider).searchHitter(inputText);
  }

  void onSelectedHitter(Hitter value) {
    // 回答入力用のTextFieldのフォーカスを外す
    FocusManager.instance.primaryFocus?.unfocus();
    _updateEnteredHitter(value);
  }

  /// 諦めるボタンをタップした際の処理。
  Future<void> onTapRetire() async {
    ref.read(navigatorKeyControllerProvider).showDialogWithChild(
          child: ConfirmDialog(
            confirmText: QuizType.daily.retireConfirmText,
            onPressedYes: _onAcceptRetire,
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
            onPressedYes: () async => _submitAnswer(hitterName),
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
            onPressedYes: () {
              _openAll();
              ref.read(appRouterProvider).maybePop();
            },
          ),
        );
  }

  Future<void> _submitAnswer(String hitterName) async {
    // interstitial 広告を作成する。
    await _createInterstitialAd();

    // * 正解の場合
    final isCorrect = state.value!.hitterQuiz.isCorrectEnteredHitter;
    if (isCorrect) {
      _markCorrect();
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
    final hitterQuizState = state.value!.hitterQuiz;
    await ref
        .read(quizResultServiceProvider)
        .updateDailyQuizResult(questionedAt, hitterQuizState);

    // ダイアログを閉じる。
    final context = ref.read(navigatorKeyProvider).currentContext!;
    if (context.mounted) {
      context.pop();
    }

    ref.invalidateSelf();

    /// 画面遷移する。
    await ref
        .read(appRouterProvider)
        .push(ResultDailyQuizRoute(hitterQuizState: hitterQuizState));
  }

  bool get _isFinalAnswer =>
      state.value!.hitterQuiz.incorrectCount == _maxCanIncorrectCount;
}
