import 'package:intl/intl.dart';

import '../../feature/daily_quiz/util/daily_quiz_constant.dart';

extension DateTimeExtension on DateTime {
  /// [yyyy/MM/dd] の形式の文字列に変換する。
  String toFormattedString() => DateFormat('yyyy/MM/dd').format(this);

  /// [MM/dd HH:mm] の形式の文字列に変換する。
  String toFormattedStringWithTime() => DateFormat('MM/dd HH:mm').format(this);

  /// アプリ内の「今日の日付」を取得する。
  DateTime calculateDateInApp() {
    final nowInApp = subtract(
      const Duration(hours: borderHourForTodayInApp),
    );
    final todayInApp = DateTime(nowInApp.year, nowInApp.month, nowInApp.day);

    return todayInApp;
  }

  /// 当月の最終日を取得する。
  DateTime get lastDayOfMonth {
    final nextMonth = DateTime(year, month + 1);
    final lastDayOfMonth = nextMonth.subtract(const Duration(days: 1));

    return lastDayOfMonth;
  }

  /// 指定された日付の [borderHourForTodayInApp] の時刻を返す。
  /// [daysOffset]: 0なら当日、1なら翌日、-1なら前日を表す。
  DateTime getChangeTime(int daysOffset) {
    final changeTime = DateTime(
      year,
      month,
      day + daysOffset,
      borderHourForTodayInApp,
    );
    return changeTime;
  }
}
