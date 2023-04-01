import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../common_widget/async_value_handler.dart';
import '../../../../util/constant/hitting_stats_constant.dart';
import '../../../../util/extension/date_time_extension.dart';
import '../../application/quiz_result_service.dart';
import '../../application/quiz_result_state.dart';
import '../../domain/daily_hitter_quiz_result.dart';
import '../gallery_detail/daily_quiz_gallery_detail_page.dart';

class DailyQuizGalleryListPage extends ConsumerWidget {
  const DailyQuizGalleryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TableCalendar<dynamic>(
      firstDay: DateTime.utc(2023, 2),
      // 現在のゲーム内月の最終日をlastDayに設定
      lastDay: DateTime.now().calculateDateInApp().lastDayOfMonth,
      daysOfWeekHeight: 24,
      availableCalendarFormats: const {CalendarFormat.month: '月'},
      focusedDay: DateTime.now().calculateDateInApp(),
      locale: 'ja_JP',
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, _) {
          return CalenderCell(date: date);
        },

        todayBuilder: (context, date, _) {
          return CalenderCell(date: date);
        },

        // 範囲外の日付は空のContainerを返す
        disabledBuilder: (context, _, __) => Container(),

        // 範囲内の選択中の月に含まれない日付は空のContainerを返す
        outsideBuilder: (context, _, __) => Container(),
      ),
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

        if (dailyHitterQuizResult.resultMap.containsKey(formattedDate)) {
          final hitterQuizResult =
              dailyHitterQuizResult.resultMap[formattedDate]!;
          return InkWell(
            onTap: () {
              final quizResultService = ref.read(quizResultServiceProvider);

              quizResultService.updateHitterQuizFromResult(
                hitterQuizResult,
                QuizType.daily,
              );
              quizResultService.updateSelectedDate(date);

              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (_) => const DailyQuizGalleryDetailPage(),
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
        return const Center(
          child: Text('-'),
        );
      },
    );
  }
}