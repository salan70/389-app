import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/navigator_key_providers.dart';
import '../../../component/quiz_widget.dart';

class ResultQuizWidget extends ConsumerWidget {
  const ResultQuizWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shareKey = ref.watch(resultQuizWidgetKeyProvider);

    return RepaintBoundary(
      key: shareKey,
      child: ColoredBox(
        color: Theme.of(context).colorScheme.background,
        child: const QuizWidget(
          willUpdate: false,
        ),
      ),
    );
  }
}
