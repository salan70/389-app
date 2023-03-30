import 'package:baseball_quiz_app/util/extension/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/async_value_handler.dart';
import '../../../application/quiz_result_state.dart';
import '../../../domain/daily_hitter_quiz_result.dart';

class ResultInfoWidget extends ConsumerWidget {
  const ResultInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler(
      value: ref.watch(dailyQuizResultProvider),
      builder: (DailyHitterQuizResult dailyHitterQuizResult) {
        final selectedDate =
            ref.watch(selectedDateProvider)!.toFormattedString();
        final quizResult = dailyHitterQuizResult.resultMap[selectedDate]!;

        return Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${quizResult.updatedAt.toFormattedString()}にプレイ',
              ),
              Text(
                '${quizResult.incorrectCount}ミス',
              ),
              Text(
                '${quizResult.unveilPercentage}%'
                '（${quizResult.unveilCount}/${quizResult.totalStatsCount}）'
                '表示',
              ),
            ],
          ),
        );
      },
    );
  }
}
