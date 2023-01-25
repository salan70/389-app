import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/is_correct_quiz.state.dart';
import 'retire_confirm_dialog.dart';

class RetireButtonWidget extends ConsumerWidget {
  const RetireButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
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
    );
  }
}
