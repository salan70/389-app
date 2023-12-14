import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../util/extension/date_time_extension.dart';
import 'daily_quiz_calender_cell.dart';

class DailyQuizGalleryListPage extends ConsumerWidget {
  const DailyQuizGalleryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayInApp = DateTime.now().calculateDateInApp();

    /// アプリ内日付の月の最終日
    final lastDayOfInAppThisMonth = todayInApp.lastDayOfMonth;

    return ListView(
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
            defaultBuilder: (context, date, _) =>
                DailyQuizCalenderCell(date: date),

            todayBuilder: (context, date, _) =>
                DailyQuizCalenderCell(date: date),

            // 範囲外の日付は空のContainerを返す。
            disabledBuilder: (context, _, __) => const SizedBox.shrink(),

            // 範囲内の選択中の月に含まれない日付は空のContainerを返す。
            outsideBuilder: (context, _, __) => const SizedBox.shrink(),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '過去の日付（-）をタップして動画広告を見ると、\n'
            'その日の「今日の1問」をプレイできます！\n'
            '※ 未プレイの場合に限ります。',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 160),
      ],
    );
  }
}
