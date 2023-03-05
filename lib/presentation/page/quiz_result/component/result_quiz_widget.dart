import 'package:flutter/material.dart';

import '../../../component/quiz_widget.dart';

class ResultQuizWidget extends StatelessWidget {
  const ResultQuizWidget({
    super.key,
    required this.globalKey,
  });

  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: ColoredBox(
        color: Theme.of(context).colorScheme.background,
        child: const QuizWidget(
          willRebuild: false,
        ),
      ),
    );
  }
}
