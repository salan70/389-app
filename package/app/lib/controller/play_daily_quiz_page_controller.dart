import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../component/quiz_play/incorrect_dialog.dart';
import '../core/common_widget/dialog/confirm_dialog.dart';
import '../core/router/app_router.dart';
import '../core/router/scaffold_messenger_key.dart';
import '../core/util/extension/context_extension.dart';

part 'play_daily_quiz_page_controller.g.dart';

@riverpod
PlayDailyQuizPageController playDailyQuizPageController(
  PlayDailyQuizPageControllerRef ref,
) =>
    PlayDailyQuizPageController(ref);

class PlayDailyQuizPageController {
  PlayDailyQuizPageController(this._ref);

  final Ref _ref;

  static const _maxCanIncorrectCount = 2;

  /// 今日の1問の回答を送信する際の処理。
  ///
  /// [hitterName] が null の場合、[ArgumentError] をスローする。
  Future<void> onTapSubmitAnswer(
    String? hitterName,
    DateTime questionedAt,
  ) async {
    if (hitterName == null) {
      throw ArgumentError.notNull('hitterName');
    }

    final notifier = _ref.read(
      hitterQuizNotifierProvider(QuizType.daily, questionedAt: questionedAt)
          .notifier,
    );

    // 間違えれる回数が上限に達している（最後の回答を送信している）場合、
    // 確認ダイアログを表示する
    final isFinalAnswer = notifier.isFinalAnswer(_maxCanIncorrectCount);
    if (isFinalAnswer) {
      _showConfirmLastSubmitDialog(hitterName, questionedAt);
      return;
    }

    await _submitAnswer(hitterName, questionedAt);
  }

  /// 最終回答時の確認ダイアログを表示する。
  ///
  /// このダイアログで回答することを承認した場合、二度と [questionedAt] の今日の1問に回答できない。
  void _showConfirmLastSubmitDialog(String hitterName, DateTime questionedAt) {
    _ref.read(scaffoldMessengerKeyProvider).currentContext!.showDialogWithChild(
          child: ConfirmDialog(
            confirmText: 'これが最後のチャンスです。\n本当にその回答でよろしいですか？',
            onPressedYes: () async => _submitAnswer(hitterName, questionedAt),
          ),
          barrierDismissible: false,
        );
  }

  Future<void> onShowAllStat(DateTime questionedAt) async {
    // 回答入力用の TextField のフォーカスを外す。
    FocusManager.instance.primaryFocus?.unfocus();

    final notifier = _ref.read(
      hitterQuizNotifierProvider(QuizType.daily, questionedAt: questionedAt)
          .notifier,
    );

    if (notifier.canOpen()) {
      _showConfirmOpenAllDialog(notifier);
    }
  }

  Future<void> onShowSingleStat(DateTime questionedAt) async {
    // 回答入力用の TextField のフォーカスを外す。
    FocusManager.instance.primaryFocus?.unfocus();

    final notifier = _ref.read(
      hitterQuizNotifierProvider(QuizType.daily, questionedAt: questionedAt)
          .notifier,
    );

    if (notifier.canOpen()) {
      notifier.openRandom();
    }
  }

  Future<List<Hitter>> onSearchHitter(
    DateTime questionedAt,
    String inputText,
  ) async {
    final notifier = _ref.read(
      hitterQuizNotifierProvider(QuizType.daily, questionedAt: questionedAt)
          .notifier,
    );
    notifier.updateEnteredHitter(null);

    return _ref.read(hitterQuizServiceProvider).searchHitter(inputText);
  }

  void onSelectedHitter(DateTime questionedAt, Hitter value) {
    // 回答入力用のTextFieldのフォーカスを外す
    FocusManager.instance.primaryFocus?.unfocus();

    final notifier = _ref.read(
      hitterQuizNotifierProvider(QuizType.daily, questionedAt: questionedAt)
          .notifier,
    );
    notifier.updateEnteredHitter(value);
  }

  void _showConfirmOpenAllDialog(HitterQuizNotifier notifier) {
    _ref.read(scaffoldMessengerKeyProvider).currentContext!.showDialogWithChild(
          child: ConfirmDialog(
            confirmText: '本当に全ての成績を表示しますか？',
            onPressedYes: () {
              notifier.openAll();
              _ref.read(appRouterProvider).pop();
            },
          ),
        );
  }

  Future<void> _submitAnswer(String hitterName, DateTime questionedAt) async {
    // interstitial 広告を作成する。
    await _createInterstitialAd();

    final notifier = _ref.read(
      hitterQuizNotifierProvider(QuizType.daily, questionedAt: questionedAt)
          .notifier,
    );

    // * 正解の場合
    final isCorrect = notifier.isCorrectHitterQuiz();
    if (isCorrect) {
      notifier.markCorrect();
      await _finishQuiz(questionedAt);
      return;
    }

    // * 不正解の場合
    notifier.addIncorrectCount();

    // interstitial 広告を確率で表示する。
    await _ref.read(interstitialAdServiceProvider).randomShowAd();

    // ** 最後の回答の場合
    final isFinalAnswer = notifier.isFinalAnswer(_maxCanIncorrectCount);
    if (isFinalAnswer) {
      await _finishQuiz(questionedAt);
      return;
    }

    // ** 最後の回答でない場合
    _showIncorrectDialog(hitterName, questionedAt);
  }

  Future<void> _createInterstitialAd() async {
    final interstitialAdService = _ref.read(interstitialAdServiceProvider);

    await interstitialAdService.createAd();
    await interstitialAdService.waitResult();
  }

  void _showIncorrectDialog(String hitterName, DateTime questionedAt) {
    _ref.read(scaffoldMessengerKeyProvider).currentContext!.showDialogWithChild(
          child: IncorrectDialog.daily(
            hitterName: hitterName,
            questionedAt: questionedAt,
          ),
          barrierDismissible: false,
        );
  }

  /// クイズ終了（最終回答）時の処理。
  ///
  /// dailyQuizResult を更新し、結果ページに遷移する。
  Future<void> _finishQuiz(DateTime questionedAt) async {
    await _ref
        .read(quizResultServiceProvider)
        .updateDailyQuizResult(questionedAt);

    await _ref
        .read(appRouterProvider)
        .push(ResultDailyQuizRoute(questionedAt: questionedAt));
  }

  /// 今日の1問をリタイアする際の処理。
  Future<void> onRetire(DateTime questionedAt) async =>
      _finishQuiz(questionedAt);
}
