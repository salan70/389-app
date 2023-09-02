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
          Row(
            children: [
              Text(
                '${quizResult.incorrectCount}ミス',
              ),
              const SizedBox(width: 16),
              Text(
                '${quizResult.unveilPercentage}%'
                '表示'
                '（${quizResult.unveilCount}/${quizResult.totalStatsCount}）',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
