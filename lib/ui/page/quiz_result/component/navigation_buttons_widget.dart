import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/hitter_quiz_ui_service.dart';
import '../../play_quiz/play_quiz_page.dart';
import '../../prepare_quiz/prepare_quiz_page.dart';
import '../../top/top_page.dart';

class NavigationButtonsWidget extends ConsumerWidget {
  const NavigationButtonsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<Widget>(
                builder: (_) => const TopPage(),
              ),
            );
          },
          child: const Text('TOPへ戻る'),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<Widget>(
                builder: (_) => const PrepareQuizPage(),
              ),
            );
          },
          child: const Text('条件を再設定'),
        ),
      ],
    );
  }
}
