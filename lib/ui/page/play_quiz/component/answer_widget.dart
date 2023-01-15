import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textfield_search/textfield_search.dart';

import '../../../../model/ui/hitter_id_by_name.dart';
import '../../../../usecase/quiz_usecase.dart';
import '../../quiz_result/quiz_result_page.dart';
import 'answer_view_model.dart';
import 'incorrect_dialog.dart';

class AnswerWidget extends ConsumerWidget {
  const AnswerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ScrollController();
    final textEditingController = TextEditingController();

    final viewModel = ref.watch(answerViewModelProvider);
    final selectedHitterIdNotifier =
        ref.watch(selectedHitterIdProvider.notifier);
    final quizUsecase = ref.watch(quizUsecaseProvider);

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
            return viewModel.searchHitter(textEditingController.text);
          },
          getSelectedValue: (HitterIdByName value) {
            selectedHitterIdNotifier.state = value.id;
          },
        ),
        TextButton(
          onPressed: () async {
            // TODO(me): 回答が無効な値の場合、ボタンを押せなくする。
            // あるいは、押したら回答が無効な旨を表示する

            final isCorrect = quizUsecase.isCorrectHitterQuiz();

            // TODO(me): 結果表示までちょっとじらす（ローディング表示？）

            // 正解の場合
            if (isCorrect) {
              await Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (_) => const QuizResultPage(),
                ),
              );
            }
            // 不正解の場合
            else {
              await showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return IncorrectDialog(
                    selectedHitter: textEditingController.text,
                  );
                },
              );
            }
          },
          child: const Text('回答する'),
        ),
      ],
    );
  }
}
