import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';

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
  @override
  void initState() {
    super.initState();

    // 画面が描画されたら紙吹雪を表示する。
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.isCorrect) {
        Confetti.launch(
          context,
          options: const ConfettiOptions(
            particleCount: 500,
            spread: 70,
            y: 0.9,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
