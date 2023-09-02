import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/confirm_dialog.dart';
import '../../../../../common_widget/my_button.dart';
import '../../../../../util/constant/button_type_constant.dart';
import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../../../util/constant/strings_constant.dart';
import '../../../../quiz_result/application/quiz_result_service.dart';
import '../../../application/answer_state.dart';
import '../../../application/hitter_quiz_state.dart';
import '../../quiz_result/daily_quiz_result/daily_quiz_result_page.dart';
import '../../quiz_result/normal_quiz_result/normal_quiz_result_page.dart';

class RetireButton extends ConsumerWidget {
  const RetireButton({super.key, required this.buttonType});

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuiz = ref.watch(hitterQuizStateProvider);

    return hitterQuiz.maybeWhen(
      orElse: Container.new,
      data: (data) {
        final quizType = data!.quizType;
        return MyButton(
          buttonType: buttonType,
          onPressed: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                final retireConfirmText = quizType == QuizType.normal
                    ? normalQuizRetireConfirmText
                    : dailyQuizRetireConfirmText;

                final resultPage = quizType == QuizType.normal
                    ? const NormalQuizResultPage()
                    : const DailyQuizResultPage();

                return ConfirmDialog(
                  confirmText: retireConfirmText,
                  onPressedYes: () async {
                    final quizResultService =
                        ref.read(quizResultServiceProvider);

                    if (quizType == QuizType.normal) {
                      await quizResultService.createNormalQuizResult();
                    } else {
                      await quizResultService.updateDailyQuizResult();
                    }

                    // submittedHitterProviderを明示的にdisposeする
                    ref.invalidate(submittedHitterProvider);

                    if (context.mounted) {
                      await Navigator.of(context).push(
                        MaterialPageRoute<Widget>(
                          builder: (_) => resultPage,
                        ),
                      );
                    }
                  },
                );
              },
            );
          },
          child: const Text('諦める'),
        );
      },
    );
  }
}
