import 'dart:io';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

// ! iOS だと紙吹雪がうまく表示されない。
// ! どうやらパッケージ側のバグっぽい。
// ! 参考: https://github.com/funwithflutter/flutter_confetti/issues/55
class CustomConfettiWidget extends StatefulWidget {
  const CustomConfettiWidget({
    super.key,
    required this.isCorrect,
  });

  final bool isCorrect;

  @override
  State<CustomConfettiWidget> createState() => _CustomConfettiWidgetState();
}

class _CustomConfettiWidgetState extends State<CustomConfettiWidget> {
  final confettiController =
      ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();

    // iOS の場合は紙吹雪を表示しない。
    if (Platform.isIOS) {
      return;
    }

    if (widget.isCorrect) {
      confettiController.play();
    }
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: confettiController,
      emissionFrequency: 0.2,
      blastDirection: 3 * pi / 2,
      particleDrag: 0.005,
    );
  }
}
