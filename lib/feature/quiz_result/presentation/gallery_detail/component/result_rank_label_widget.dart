import 'package:baseball_quiz_app/util/constant/hitting_stats_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/quiz_result_state.dart';

class ResultRankLabelWidget extends ConsumerWidget {
  const ResultRankLabelWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizResult = ref.watch(quizResultStateProvider)!;
    return Center(
      child: FittedBox(
        child: quizResult.resultRank.largeLabelWidget,
      ),
    );
  }
}
