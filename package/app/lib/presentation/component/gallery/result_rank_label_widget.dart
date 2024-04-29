import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../util/result_rank_extension.dart';

class ResultRankLabelWidget extends ConsumerWidget {
  const ResultRankLabelWidget({super.key, required this.quizResult});

  final HitterQuizResult quizResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: FittedBox(
        child: quizResult.resultRank.largeLabelWidget,
      ),
    );
  }
}
