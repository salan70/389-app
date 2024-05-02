import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../component/play_quiz_common/incorrect_dialog.dart';
import '../core/common_widget/dialog/confirm_dialog.dart';
import '../core/router/app_router.dart';
import '../core/router/scaffold_messenger_key.dart';
import '../core/util/extension/context_extension.dart';

part 'play_normal_quiz_page_controller.g.dart';

@riverpod
PlayNormalQuizPageController playNormalQuizPageController(
  PlayNormalQuizPageControllerRef ref,
) =>
    PlayNormalQuizPageController(ref);

class PlayNormalQuizPageController {
  PlayNormalQuizPageController(this._ref);

  final Ref _ref;

  /// 回答を送信する際の処理。
  ///
  /// [hitterName] が null の場合、[ArgumentError] をスローする。
  Future<void> onSubmitAnswer(String? hitterName) async {
    if (hitterName == null) {
      throw ArgumentError.notNull('hitterName');
    }

    // interstitial 広告を作成する。
    await _createInterstitialAd();

    final hitterQuizNotifier = _ref.read(
      hitterQuizNotifierProvider(QuizType.normal, questionedAt: null).notifier,
    );
    final isCorrect = hitterQuizNotifier.isCorrectHitterQuiz();

    // * 正解の場合。
    if (isCorrect) {
      hitterQuizNotifier.markCorrect();
      await _ref.read(quizResultServiceProvider).createNormalQuizResult();

      // `createNormalQuizResult()` でエラーが発生しなかった場合のみ、
      // 画面遷移する。
      await _ref.read(appRouterProvider).push(ResultNormalQuizRoute());

      return;
    }

    // * 不正解の場合。
    hitterQuizNotifier.addIncorrectCount();

    // 広告を確率で表示する。
    await _ref.read(interstitialAdServiceProvider).randomShowAd();

    _showIncorrectDialog(hitterName);
  }

  Future<List<Hitter>> onSearchHitter(
    String inputText,
  ) async {
    final notifier = _ref.read(
      hitterQuizNotifierProvider(QuizType.normal, questionedAt: null).notifier,
    );
    notifier.updateEnteredHitter(null);

    return _ref.read(hitterQuizServiceProvider).searchHitter(inputText);
  }

  Future<void> onShowAllStat() async {
    // 回答入力用の TextField のフォーカスを外す。
    FocusManager.instance.primaryFocus?.unfocus();

    final notifier = _ref.read(
      hitterQuizNotifierProvider(QuizType.normal, questionedAt: null).notifier,
    );

    if (notifier.canOpen()) {
      _showConfirmOpenAllDialog(notifier);
    }
  }

  Future<void> onShowSingleStat() async {
    // 回答入力用の TextField のフォーカスを外す。
    FocusManager.instance.primaryFocus?.unfocus();

    final notifier = _ref.read(
      hitterQuizNotifierProvider(QuizType.normal, questionedAt: null).notifier,
    );

    if (notifier.canOpen()) {
      notifier.openRandom();
    }
  }

  Future<void> onRetire() async {
    await _ref.read(quizResultServiceProvider).createNormalQuizResult();
    await _ref.read(appRouterProvider).push(ResultNormalQuizRoute());
  }

  void _showIncorrectDialog(String hitterName) {
    _ref.read(scaffoldMessengerKeyProvider).currentContext!.showDialogWithChild(
          child: IncorrectDialog.normal(hitterName: hitterName),
          barrierDismissible: false,
        );
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

  Future<void> _createInterstitialAd() async {
    final interstitialAdService = _ref.read(interstitialAdServiceProvider);

    await interstitialAdService.createAd();
    await interstitialAdService.waitResult();
  }
}
