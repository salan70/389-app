import 'package:flutter/material.dart';
import 'package:model/model.dart';

class ResultInfoWidget extends StatelessWidget {
  const ResultInfoWidget({super.key, required this.quizResult});

  final HitterQuizResult quizResult;

  @override
  Widget build(BuildContext context) {
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
                '${quizResult.hitterQuiz.incorrectCount}ミス',
              ),
              const SizedBox(width: 16),
              Text(
                '${quizResult.unveilPercentage}%'
                '表示'
                '（${quizResult.hitterQuiz.unveilCount}/${quizResult.totalStatsCount}）',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
