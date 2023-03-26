import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyQuizGalleryListPage extends ConsumerWidget {
  const DailyQuizGalleryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TableCalendar<dynamic>(
      firstDay: DateTime.utc(2023, 2),
      // TODO 今日の日付から取得する（ゲーム内の「今日」の日付をlastDayに設定する）
      lastDay: DateTime.utc(2023, 3, 31),
      daysOfWeekHeight: 24,
      availableCalendarFormats: const {CalendarFormat.month: '月'},
      // TODO 今日の日付から取得する（ゲーム内の「今日」の日付をfocusedDay設定する）
      focusedDay: DateTime.now(),
      locale: 'ja_JP',
      calendarBuilders: CalendarBuilders(
        // 範囲外の日付は空のContainerを返す
        disabledBuilder: (context, date, _) => Container(),

        // 範囲内の選択中の月に含まれない日付は空のContainerを返す
        outsideBuilder: (context, date, _) => Container(),
      ),
    );
  }
}
