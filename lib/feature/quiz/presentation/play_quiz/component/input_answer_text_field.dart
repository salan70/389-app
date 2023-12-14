import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textfield_search/textfield_search.dart';

import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../application/hitter_quiz_notifier.dart';
import '../../../application/hitter_quiz_service.dart';
import '../../../domain/hitter.dart';

class InputAnswerTextField extends ConsumerWidget {
  InputAnswerTextField.normal({super.key, required this.textEditingController})
      : quizType = QuizType.normal;

  InputAnswerTextField.daily({super.key, required this.textEditingController})
      : quizType = QuizType.daily;

  final QuizType quizType;

  /// 回答入力用に使用する [TextEditingController].
  ///
  /// リビルドしても入力した文字列が保持されるように、親の Widget で管理する。
  final TextEditingController textEditingController;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuizNotifier =
        ref.watch(hitterQuizNotifierProvider(quizType).notifier);

    return TextFieldSearch(
      label: '選手名',
      controller: textEditingController,
      minStringLength: 0,
      itemsInView: 5,
      scrollbarDecoration: ScrollbarDecoration(
        controller: _scrollController,
        theme: const ScrollbarThemeData(),
      ),
      future: () {
        hitterQuizNotifier.updateEnteredHitter(null);
        return ref
            .read(hitterQuizServiceProvider)
            .searchHitter(textEditingController.text);
      },
      getSelectedValue: (Hitter value) {
        // 回答入力用のTextFieldのフォーカスを外す
        FocusManager.instance.primaryFocus?.unfocus();
        hitterQuizNotifier.updateEnteredHitter(value);
      },
    );
  }
}
