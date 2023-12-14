import 'package:baseball_quiz_app/feature/analytics/application/analytics_service.dart';
import 'package:baseball_quiz_app/util/mixin/presentation_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../common_widget/async_value_handler.dart';
import '../../../../common_widget/my_button.dart';
import '../../../../util/constant/hitting_stats_constant.dart';
import '../../../../util/extension/date_time_extension.dart';
import '../../../../util/logger.dart';
import '../../../admob/application/rewarded_ad_notifier.dart';
import '../../../admob/domain/rewarded_ad_state.dart';
import '../../../daily_quiz/application/daily_quiz_state.dart';
import '../../../quiz/application/hitter_quiz_notifier.dart';
import '../../../quiz/presentation/play_quiz/play_daily_quiz/play_daily_quiz_page.dart';
import '../../application/quiz_result_state.dart';
import '../../domain/daily_hitter_quiz_result.dart';
import '../gallery_detail/daily_quiz_gallery_detail_page.dart';

class DailyQuizGalleryListPage extends ConsumerWidget {
  const DailyQuizGalleryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayInApp = DateTime.now().calculateDateInApp();

    /// アプリ内日付の月の最終日
    final lastDayOfInAppThisMonth = todayInApp.lastDayOfMonth;

    return Column(
      children: [
        TableCalendar<dynamic>(
          firstDay: DateTime.utc(2023, 4),
          // 現在のゲーム内月の最終日をlastDayに設定
          lastDay: lastDayOfInAppThisMonth,
          daysOfWeekHeight: 24,
          availableCalendarFormats: const {CalendarFormat.month: '月'},
          focusedDay: todayInApp,
          locale: 'ja_JP',
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, date, _) => CalenderCell(date: date),

            todayBuilder: (context, date, _) => CalenderCell(date: date),

            // 範囲外の日付は空のContainerを返す。
            disabledBuilder: (context, _, __) => const SizedBox.shrink(),

            // 範囲内の選択中の月に含まれない日付は空のContainerを返す。
            outsideBuilder: (context, _, __) => const SizedBox.shrink(),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '過去の日付（-）をタップして動画広告を見ると、\n'
          'その日の「今日の1問」をプレイできます！\n'
          '※ 未プレイの場合に限ります。',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class CalenderCell extends ConsumerStatefulWidget {
  const CalenderCell({super.key, required this.date});

  final DateTime date;

  @override
  ConsumerState<CalenderCell> createState() => _CalenderCellState();
}

class _CalenderCellState extends ConsumerState<CalenderCell>
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
                child: hitterQuizResult.resultRank.smallLabellWidget,
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
