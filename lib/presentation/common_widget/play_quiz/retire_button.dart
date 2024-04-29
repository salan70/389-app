import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../presentation/common_widget/confirm_dialog.dart';
import '../../../../../presentation/common_widget/my_button.dart';
import '../../../../../util/enum/quiz_type.dart';
import '../../../../feature/quiz_result/application/quiz_result_service.dart';
import '../../page/daily_quiz_result/daily_quiz_result_page.dart';
import '../../page/normal_quiz_result/normal_quiz_result_page.dart';

class RetireButton extends ConsumerWidget {
  const RetireButton.normal({super.key, required this.buttonType})
      : quizType = QuizType.normal,
        questionedAt = null;

  const RetireButton.daily({
    super.key,
    required this.buttonType,
    required this.questionedAt,
  }) : quizType = QuizType.daily;

  final ButtonType buttonType;
  final QuizType quizType;

  /// 対象となる DailyQuiz の出題日。
  ///
  /// [QuizType.daily] の場合、必須。
  final DateTime? questionedAt;

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
                ? NormalQuizResultPage()
                : DailyQuizResultPage(
                    questionedAt: questionedAt!,
                  );

            return ConfirmDialog(
              confirmText: quizType.retireConfirmText,
              onPressedYes: () async {
                final quizResultService = ref.read(quizResultServiceProvider);

                if (quizType == QuizType.normal) {
                  await quizResultService.createNormalQuizResult();
                } else {
                  if (questionedAt == null) {
                    throw ArgumentError.notNull('questionedAt');
                  }
                  await quizResultService.updateDailyQuizResult(questionedAt!);
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
