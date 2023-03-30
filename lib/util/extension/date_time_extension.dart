import 'package:intl/intl.dart';

import '../../feature/daily_quiz/util/daily_quiz_constant.dart';

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    return DateFormat('yyyy/MM/dd').format(this);
  }

  /// アプリ内の「今日の日付」を取得する
  DateTime calculateDateInApp() {
    final nowInApp = subtract(
      const Duration(hours: borderHourForTodayInApp),
    );
    final todayInApp = DateTime(nowInApp.year, nowInApp.month, nowInApp.day);

    return todayInApp;
  }

  /// 月の最終日を取得する
  DateTime get lastDayOfMonth {
    final nextMonth = DateTime(year, month + 1);
    final lastDayOfMonth = nextMonth.subtract(const Duration(days: 1));
    return lastDayOfMonth;
  }
}
