import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../util/extension/date_time_extension.dart';
import '../../../application/quiz_result_state.dart';

class ResultInfoWidget extends ConsumerWidget {
  const ResultInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizResult = ref.watch(quizResultStateProvider)!;
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
  }
}
