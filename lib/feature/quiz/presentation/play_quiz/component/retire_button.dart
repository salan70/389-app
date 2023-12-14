import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/confirm_dialog.dart';
import '../../../../../common_widget/my_button.dart';
import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../../quiz_result/application/quiz_result_service.dart';
import '../../quiz_result/daily_quiz_result/daily_quiz_result_page.dart';
import '../../quiz_result/normal_quiz_result/normal_quiz_result_page.dart';

class RetireButton extends ConsumerWidget {
  const RetireButton.normal({super.key, required this.buttonType})
      : quizType = QuizType.normal;

  const RetireButton.daily({super.key, required this.buttonType})
      : quizType = QuizType.daily;

  final ButtonType buttonType;
  final QuizType quizType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'retire_button',
      buttonType: buttonType,
      onPressed: () {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            final resultPage = quizType == QuizType.normal
                ? const NormalQuizResultPage()
                : DailyQuizResultPage();

            return ConfirmDialog(
              confirmText: quizType.retireConfirmText,
              onPressedYes: () async {
                final quizResultService = ref.read(quizResultServiceProvider);

                if (quizType == QuizType.normal) {
                  await quizResultService.createNormalQuizResult();
                } else {
                  await quizResultService.updateDailyQuizResult();
                }

                if (context.mounted) {
                  await Navigator.of(context).push(
                    MaterialPageRoute<Widget>(
                      builder: (_) => resultPage,
                      settings: RouteSettings(
                        name: '/${quizType.label}_quiz_result_page',
                      ),
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
  }
}
