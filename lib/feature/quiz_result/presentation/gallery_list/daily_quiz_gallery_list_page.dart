import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../common_widget/async_value_handler.dart';
import '../../../../common_widget/my_button.dart';
import '../../../../util/constant/hitting_stats_constant.dart';
import '../../../../util/extension/date_time_extension.dart';
import '../../../admob/application/rewarded_ad_notifier.dart';
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

class CalenderCell extends ConsumerWidget {
  const CalenderCell({super.key, required this.date});

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
            onTap: () {
              Navigator.push(
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
        else if (date.isBefore(DateTime.now().calculateDateInApp())) {
          return InkWell(
            onTap: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return _ConfirmPlayPastDailyQuizDialog(
                    date: date,
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
        // todo エラーハンドリング
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
          onPressed: () => Navigator.pop(context),
        ),
        const SizedBox(width: 4),
        MyButton(
          buttonName: 'confirm_yes_button',
          buttonType: ButtonType.alert,
          onPressed: () {
            ref.read(rewardedAdNotifierProvider.notifier).showAd(() {
              // todo dailyQuiz の作成と画面遷移
            });
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
