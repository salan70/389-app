import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/is_correct_quiz.state.dart';
import 'retire_confirm_dialog.dart';

class RetireButton extends ConsumerWidget {
  const RetireButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        width: 120,
        child: TextButton(
          onPressed: () async {
            final notifier = ref.read(isCorrectQuizStateProvider.notifier);
            notifier.state = false;

            await showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return const RetireConfirmDialog();
              },
            );
          },
          child: const Text('諦める'),
        ),
      ),
    );
  }
}
