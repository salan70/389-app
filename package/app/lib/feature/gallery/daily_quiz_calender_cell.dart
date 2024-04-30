import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/async_value_handler.dart';
import '../../../core/common_widget/button/my_button.dart';
import '../../../core/util/presentation_mixin.dart';
import '../../../core/util/result_rank_extension.dart';
import '../../core/router/app_router.dart';

class DailyQuizCalenderCell extends ConsumerWidget with PresentationMixin {
  const DailyQuizCalenderCell({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler(
      value: ref.watch(dailyQuizResultProvider),
      builder: (DailyHitterQuizResult dailyHitterQuizResult) {
        final formattedDate = date.toFormattedString();

        // プレイ済みの日付。
        if (dailyHitterQuizResult.resultMap.containsKey(formattedDate)) {
          final hitterQuizResult =
              dailyHitterQuizResult.resultMap[formattedDate]!;
          return InkWell(
            onTap: () async {
              await ref
                  .read(analyticsServiceProvider)
                  .logTapButton('to_daily_quiz_gallery_detail_page');

              if (context.mounted) {
                await context.pushRoute(
                  GalleryDetailDailyQuizRoute(
                    hitterQuizResult: hitterQuizResult,
                  ),
                );
              }
            },
            child: Center(
              child: FittedBox(
                child: hitterQuizResult.resultRank.smallLabelWidget,
              ),
            ),
          );
        }
        // 未プレイ かつ 過去の日付。
        if (date.isBefore(DateTime.now().calculateDateInApp())) {
          return InkWell(
            onTap: () async {
              await executeWithOverlayLoading(
                ref,
                action: () async {
                  // 念のため、 invalidate する。
                  ref.invalidate(dailyQuizProvider(date));
                  final dailyQuiz =
                      await ref.read(dailyQuizProvider(date).future);

                  // * null （未登録などで取得できなかった）の場合。
                  if (dailyQuiz == null) {
                    logger.e('$formattedDate分の今日の1問が null でした。登録漏れの可能性があります。');
                    throw Exception('daily quiz is null.');
                  }

                  await ref.read(
                    hitterQuizNotifierProvider(
                      QuizType.daily,
                      questionedAt: date,
                    ).future,
                  );
                },
                onLoadingComplete: () async {
                  await ref
                      .read(analyticsServiceProvider)
                      .logTapButton('show_confirm_play_past_daily_quiz_dialog');
                  if (!context.mounted) {
                    return;
                  }
                  await showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return _ConfirmPlayPastDailyQuizDialog(
                        date: date,
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
              await context.popRoute();
            }
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

            ref.read(rewardedAdNotifierProvider.notifier).showAd(
                  onUserEarnedReward: () => context
                      .pushRoute(PlayDailyQuizRoute(questionedAt: widget.date)),
                );
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
