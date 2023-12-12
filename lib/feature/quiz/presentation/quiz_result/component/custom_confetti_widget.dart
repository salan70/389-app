import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../application/hitter_quiz_notifier.dart';

class CustomConfettiWidget extends ConsumerStatefulWidget {
  const CustomConfettiWidget({
    super.key,
  });

  @override
  ConsumerState<CustomConfettiWidget> createState() =>
      _CustomConfettiWidgetState();
}

class _CustomConfettiWidgetState extends ConsumerState<CustomConfettiWidget> {
  final controller = ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();

    // todo: dailyにも対応させる
    // 正解している場合のみ紙吹雪を出す。
    final isCorrect = ref
        .read(hitterQuizNotifierProvider(QuizType.normal))
        .value!
        .isCorrect;
    if (isCorrect) {
      controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: controller,
      emissionFrequency: 0.2,
      blastDirection: 3 * pi / 2,
      particleDrag: 0.005,
    );
  }
}
