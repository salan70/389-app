import 'package:baseball_quiz_app/feature/quiz_result/domain/hitter_quiz_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../util/extension/date_time_extension.dart';

class ResultInfoWidget extends ConsumerWidget {
  const ResultInfoWidget({super.key, required this.quizResult});

  final HitterQuizResult quizResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
