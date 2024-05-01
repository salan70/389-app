import 'package:flutter/material.dart';
import 'package:model/model.dart';

import '../../core/util/extension/result_rank_extension.dart';

class ResultRankLabelWidget extends StatelessWidget {
  const ResultRankLabelWidget({super.key, required this.quizResult});

  final HitterQuizResult quizResult;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: quizResult.resultRank.largeLabelWidget,
      ),
    );
  }
}
