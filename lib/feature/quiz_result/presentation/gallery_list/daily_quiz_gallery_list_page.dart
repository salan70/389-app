import 'package:baseball_quiz_app/util/constant/hitting_stats_constant.dart';
import 'package:baseball_quiz_app/util/extension/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../common_widget/async_value_handler.dart';
import '../../application/quiz_result_state.dart';
import '../../domain/daily_hitter_quiz_result.dart';

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
        defaultBuilder: (context, date, _) {
          return AsyncValueHandler(
            value: ref.watch(dailyQuizResultProvider),
            builder: (DailyHitterQuizResult dailyHitterQuizResult) {
              final formattedDate = date.toFormattedString();

              if (dailyHitterQuizResult.resultMap.containsKey(formattedDate)) {
                final hitterQuizResult =
                    dailyHitterQuizResult.resultMap[formattedDate]!;
                final rankLabel = hitterQuizResult.resultRank.label;
                return Center(
                  child: Text(rankLabel),
                );
              }
              return const Center(
                child: Text('-'),
              );
            },
          );
        },

        todayBuilder: (context, date, _) {
          // TODO: Firebaseから取得したデータを元に、日付に対応するクイズの結果を表示する
          return Container(
            color: Colors.green,
          );
        },

        // 範囲外の日付は空のContainerを返す
        disabledBuilder: (context, date, _) => Container(),

        // 範囲内の選択中の月に含まれない日付は空のContainerを返す
        outsideBuilder: (context, date, _) => Container(),
      ),
    );
  }
}
