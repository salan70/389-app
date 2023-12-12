import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textfield_search/textfield_search.dart';

import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../application/hitter_quiz_notifier.dart';
import '../../../application/hitter_quiz_service.dart';
import '../../../domain/hitter.dart';

class InputAnswerTextField extends ConsumerWidget {
  InputAnswerTextField.normal({super.key}) : quizType = QuizType.normal;

  InputAnswerTextField.daily({super.key}) : quizType = QuizType.daily;

  final QuizType quizType;

  final textEditingController = TextEditingController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuizService = ref.watch(hitterQuizServiceProvider);
    final hitterQuizNotifier =
        ref.watch(hitterQuizNotifierProvider(quizType).notifier);

    return TextFieldSearch(
      label: '選手名',
      controller: textEditingController,
      minStringLength: 0,
      itemsInView: 5,
      scrollbarDecoration: ScrollbarDecoration(
        controller: scrollController,
        theme: const ScrollbarThemeData(),
      ),
      future: () {
        hitterQuizNotifier.updateEnteredHitter(null);
        return hitterQuizService.searchHitter(textEditingController.text);
      },
      getSelectedValue: (Hitter value) {
        // 回答入力用のTextFieldのフォーカスを外す
        FocusManager.instance.primaryFocus?.unfocus();
        hitterQuizNotifier.updateEnteredHitter(value);
      },
    );
  }
}
