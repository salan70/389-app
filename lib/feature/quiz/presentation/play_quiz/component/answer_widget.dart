import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textfield_search/textfield_search.dart';

import '../../../application/answer_state.dart';
import '../../../application/hitter_quiz_service.dart';
import '../../../domain/hitter.dart';

class AnswerWidget extends ConsumerWidget {
  AnswerWidget({super.key, required this.onSubmittedAnswer});

  final VoidCallback onSubmittedAnswer;
  final textEditingController = TextEditingController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuizService = ref.watch(hitterQuizServiceProvider);
    final submittedHitter = ref.watch(submittedHitterProvider);
    final submittedHitterNotifier =
        ref.watch(submittedHitterProvider.notifier);

    return Column(
      children: [
        TextFieldSearch(
          label: '選手名',
          controller: textEditingController,
          minStringLength: 0,
          itemsInView: 5,
          scrollbarDecoration: ScrollbarDecoration(
            controller: scrollController,
            theme: const ScrollbarThemeData(),
          ),
          future: () {
            submittedHitterNotifier.state = null;
            return hitterQuizService.searchHitter(textEditingController.text);
          },
          getSelectedValue: (Hitter value) {
            // 回答入力用のTextFieldのフォーカスを外す
            FocusManager.instance.primaryFocus?.unfocus();
            submittedHitterNotifier.state = value;
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 120,
          child: TextButton(
            onPressed:
                submittedHitter == null ? null : onSubmittedAnswer,
            child: const Text('回答する'),
          ),
        ),
      ],
    );
  }
}
