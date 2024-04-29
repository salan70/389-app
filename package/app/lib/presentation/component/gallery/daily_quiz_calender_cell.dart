import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../page/daily_quiz_gallery_detail_page.dart';
import '../../page/play_daily_quiz_page.dart';
import '../../util/presentation_mixin.dart';
import '../common/async_value_handler.dart';
import '../common/button/my_button.dart';

class DailyQuizCalenderCell extends ConsumerStatefulWidget {
  const DailyQuizCalenderCell({super.key, required this.date});

  final DateTime date;

  @override
  ConsumerState<DailyQuizCalenderCell> createState() => _CalenderCellState();
}

class _CalenderCellState extends ConsumerState<DailyQuizCalenderCell>
    with PresentationMixin {
  /// このセルの日付の今日の1問を、広告を見てプレイするかどうか。
  ///
  /// それぞれの日付のセルが作成されるため、該当するセルだけで
  /// プレイするかどうかを管理する必要がある。
  var _willPlay = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(
      rewardedAdNotifierProvider,
      (_, next) {
        if (!_willPlay) {
          return;
        }
        final nextState = next! as RewardAdState;
        // 広告の視聴が完了しており、 かつ、 クイズがプレイ開始されていない場合。
        // 該当日の今日の1問をプレイする。
        if (nextState.isWatchCompleted && !nextState.isStartedQuiz) {
          ref.read(rewardedAdNotifierProvider.notifier).updateIsStartedQuiz();
          Navigator.of(context).push(
            MaterialPageRoute<Widget>(
              builder: (_) => PlayDailyQuizPage(questionedAt: widget.date),
              settings: const RouteSettings(name: '/play_daily_quiz_page'),
            ),
          );
        }
      },
    );

    return AsyncValueHandler(
      value: ref.watch(dailyQuizResultProvider),
      builder: (DailyHitterQuizResult dailyHitterQuizResult) {
        final formattedDate = widget.date.toFormattedString();

        // プレイ済みの日付。
        if (dailyHitterQuizResult.resultMap.containsKey(formattedDate)) {
          final hitterQuizResult =
              dailyHitterQuizResult.resultMap[formattedDate]!;
          return InkWell(
            onTap: () async {
              await ref
                  .read(analyticsServiceProvider)
                  .logTapButton('to_daily_quiz_gallery_detail_page');
              if (!context.mounted) {
                return;
              }
              await Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (_) => DailyQuizGalleryDetailPage(
                    hitterQuizResult: hitterQuizResult,
                  ),
                  settings: const RouteSettings(
                    name: '/daily_quiz_gallery_detail_page',
                  ),
                ),
              );
            },
            child: Center(
              child: FittedBox(
                child: hitterQuizResult.resultRank.smallLabelWidget,
              ),
            ),
          );
        }
        // 未プレイ かつ 過去の日付。
        else if (widget.date.isBefore(DateTime.now().calculateDateInApp())) {
          return InkWell(
            onTap: () async {
              await executeWithOverlayLoading(
                ref,
                action: () async {
                  // 念のため、 invalidate する。
                  ref.invalidate(dailyQuizProvider(widget.date));
                  final dailyQuiz =
                      await ref.read(dailyQuizProvider(widget.date).future);

                  // * null （未登録などで取得できなかった）の場合。
                  if (dailyQuiz == null) {
                    logger.e('$formattedDate分の今日の1問が null でした。登録漏れの可能性があります。');
                    throw Exception('daily quiz is null.');
                  }

                  await ref.read(
                    hitterQuizNotifierProvider(
                      QuizType.daily,
                      questionedAt: widget.date,
                    ).future,
                  );
                },
                onLoadingComplete: () async {
                  await ref
                      .read(analyticsServiceProvider)
                      .logTapButton('show_confirm_play_past_daily_quiz_dialog');
                  setState(() {
                    _willPlay = true;
                  });
                  if (!context.mounted) {
                    return;
                  }
                  await showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return _ConfirmPlayPastDailyQuizDialog(
                        date: widget.date,
                      );
                    },
                  );
                },
              );
            },
            child: const Center(child: Text('-')),
          );
        }
        // 未来の日付。
        return const SizedBox.shrink();
      },
    );
  }
}

class _ConfirmPlayPastDailyQuizDialog extends ConsumerStatefulWidget {
  const _ConfirmPlayPastDailyQuizDialog({
    required this.date,
  });

  final DateTime date;

  @override
  ConsumerState<_ConfirmPlayPastDailyQuizDialog> createState() =>
      __ConfirmPlayPastDailyQuizDialog();
}

class __ConfirmPlayPastDailyQuizDialog
    extends ConsumerState<_ConfirmPlayPastDailyQuizDialog> {
  static const double _buttonHeight = 24;
  static const double _buttonWidth = 64;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(rewardedAdNotifierProvider.notifier).loadAd();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final rewardedAdState = ref.watch(rewardedAdNotifierProvider);
    final formattedDate = widget.date.toFormattedString();

    return AlertDialog(
      title: const Text('確認'),
      content: Text('動画広告を見て、$formattedDateの「今日の1問」をプレイしますか？\n'
          'はいをタップすると、動画広告が再生されます。\n\n'
          '※1度プレイした日付の「今日の1問」は、2度とプレイできません。\n\n'
          '※プレイ中にアプリが終了された場合、不正解となります。'),
      actionsPadding: const EdgeInsets.only(right: 24, bottom: 16),
      actions: <Widget>[
        MyButton(
          buttonName: 'confirm_no_button',
          buttonType: ButtonType.sub,
          child: const SizedBox(
            height: _buttonHeight,
            width: _buttonWidth,
            child: Center(child: Text('いいえ')),
          ),
          onPressed: () async {
            await ref
                .read(analyticsServiceProvider)
                .logTapButton('cancelled_play_past_daily_quiz');
            if (!context.mounted) {
              return;
            }
            Navigator.pop(context);
          },
        ),
        const SizedBox(width: 4),
        MyButton(
          buttonName: 'confirm_yes_button',
          buttonType: ButtonType.alert,
          onPressed: () async {
            await ref
                .read(analyticsServiceProvider)
                .logTapButton('approved_play_past_daily_quiz');
            ref.read(rewardedAdNotifierProvider.notifier).showAd();
          },
          child: SizedBox(
            height: _buttonHeight,
            width: _buttonWidth,
            child: Center(
              child: rewardedAdState.isLoaded
                  ? const Text('はい')
                  : const SizedBox(
                      // 正方形で表示させるため、 _buttonHeight を width に設定。
                      width: _buttonHeight,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
