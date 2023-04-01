import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/my_button.dart';
import '../../../application/hitter_quiz_service.dart';
import '../../play_quiz/play_normal_quiz/play_normal_quiz_page.dart';

class ReplayButton extends ConsumerWidget {
  const ReplayButton({
    super.key,
    required this.isMain,
  });

  final bool isMain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      isMain: isMain,
      onPressed: () async {
        await ref
            .read(hitterQuizServiceProvider)
            .fetchHitterQuizBySearchCondition();

        if (context.mounted) {
          await Navigator.of(context).push(
            MaterialPageRoute<Widget>(
              builder: (_) => const PlayNormalQuizPage(),
            ),
          );
        }
      },
      child: const Text('同じ条件でもう一度！'),
    );
  }
}
