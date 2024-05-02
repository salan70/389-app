import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/gallery_list_page_controller.dart';
import 'daily_quiz_calender_cell.dart';

class DailyQuizGalleryList extends ConsumerWidget {
  const DailyQuizGalleryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(dailyQuizResultProvider).when(
          // TODO(me): ローディングとエラーの UI ちゃんとする。
          loading: SizedBox.shrink,
          error: (e, s) => const SizedBox.shrink(),
          data: (dailyQuizResult) {
            // アプリ内の今日の日付。
            final todayInApp = DateTime.now().calculateDateInApp();

            // 「アプリ内日付の月」の最終日
            final lastDayOfInAppThisMonth =
                DateTime.now().calculateDateInApp().lastDayOfMonth;

            return ListView(
              children: [
                TableCalendar<dynamic>(
                  firstDay: DateTime.utc(2023, 4),
                  // 現在のゲーム内月の最終日を lastDay に設定
                  lastDay: lastDayOfInAppThisMonth,
                  daysOfWeekHeight: 24,
                  availableCalendarFormats: const {CalendarFormat.month: '月'},
                  focusedDay: todayInApp,
                  locale: 'ja_JP',
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, date, _) {
                      final formattedDate = date.toFormattedString();
                      final hitterQuizResult =
                          dailyQuizResult.resultMap[formattedDate]!;

                      return DailyQuizCalenderCell(
                        date: date,
                        dailyHitterQuizResult: dailyQuizResult,
                        onTapPlayedDailyQuiz: () => ref
                            .read(galleryListPageControllerProvider)
                            .onTapPlayedDailyQuiz(hitterQuizResult),
                        onTapNotPlayedDailyQuiz: () => ref
                            .read(galleryListPageControllerProvider)
                            .onTapNotPlayedDailyQuiz(date),
                      );
                    },

                    todayBuilder: (context, date, _) {
                      final formattedDate = date.toFormattedString();
                      final hitterQuizResult =
                          dailyQuizResult.resultMap[formattedDate]!;

                      return DailyQuizCalenderCell(
                        date: date,
                        dailyHitterQuizResult: dailyQuizResult,
                        onTapPlayedDailyQuiz: () => ref
                            .read(galleryListPageControllerProvider)
                            .onTapPlayedDailyQuiz(hitterQuizResult),
                        onTapNotPlayedDailyQuiz: () => ref
                            .read(galleryListPageControllerProvider)
                            .onTapNotPlayedDailyQuiz(date),
                      );
                    },

                    // 範囲外の日付。
                    disabledBuilder: (context, _, __) =>
                        const SizedBox.shrink(),

                    // 範囲内の選択中の月に含まれない日付。
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
          },
        );
  }
}
