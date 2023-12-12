import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomConfettiWidget extends ConsumerStatefulWidget {
  const CustomConfettiWidget({
    super.key,
    required this.isCorrect,
  });

  final bool isCorrect;

  @override
  ConsumerState<CustomConfettiWidget> createState() =>
      _CustomConfettiWidgetState();
}

class _CustomConfettiWidgetState extends ConsumerState<CustomConfettiWidget> {
  final controller = ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    if (widget.isCorrect) {
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
