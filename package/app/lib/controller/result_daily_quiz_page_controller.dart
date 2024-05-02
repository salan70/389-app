import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'result_daily_quiz_page_controller.g.dart';

@riverpod
ResultDailyQuizPageController resultDailyQuizPageController(
  ResultDailyQuizPageControllerRef ref,
) =>
    ResultDailyQuizPageController(ref);

class ResultDailyQuizPageController {
  ResultDailyQuizPageController(this._ref);

  final Ref _ref;
}
