import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../application/quiz/hitter_quiz/hitter_quiz_state.dart';
import '../../../component/confirm_dialog.dart';

class RetireButton extends ConsumerWidget {
  const RetireButton({
    super.key,
    required this.retireConfirmText,
    required this.resultPage,
  });

  final String retireConfirmText;
  final Widget resultPage;

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
                return ConfirmDialog(
                  confirmText: retireConfirmText,
                  onPressedYes: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<Widget>(
                        builder: (_) => resultPage,
                      ),
                    );
                  },
                );
              },
            );
          },
          child: const Text('諦める'),
        ),
      ),
    );
  }
}
