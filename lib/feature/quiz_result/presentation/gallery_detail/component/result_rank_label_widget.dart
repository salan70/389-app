import 'package:baseball_quiz_app/util/constant/hitting_stats_constant.dart';
import 'package:baseball_quiz_app/util/extension/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/async_value_handler.dart';
import '../../../application/quiz_result_state.dart';
import '../../../domain/daily_hitter_quiz_result.dart';

class ResultRankLabelWidget extends ConsumerWidget {
  const ResultRankLabelWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler(
      value: ref.watch(dailyQuizResultProvider),
      builder: (DailyHitterQuizResult dailyHitterQuizResult) {
        final selectedDate =
            ref.watch(selectedDateProvider)!.toFormattedString();
        final hitterQuizResult = dailyHitterQuizResult.resultMap[selectedDate]!;

        return Center(
          child: FittedBox(
            child: hitterQuizResult.resultRank.largeLabelWidget,
          ),
        );
      },
    );
  }
}
