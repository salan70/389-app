import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/confirm_dialog.dart';
import '../../../../../common_widget/my_button.dart';
import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../../quiz_result/application/quiz_result_service.dart';
import '../../quiz_result/daily_quiz_result/daily_quiz_result_page.dart';
import '../../quiz_result/normal_quiz_result/normal_quiz_result_page.dart';

class IncorrectDialog extends ConsumerWidget {
  const IncorrectDialog.normal({super.key, required this.hitterName})
      : quizType = QuizType.normal;

  const IncorrectDialog.daily({super.key, required this.hitterName})
      : quizType = QuizType.daily;

  final String hitterName;
  final QuizType quizType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('残念...'),
      content: Text('$hitterName選手ではありません'),
      actions: <Widget>[
        MyButton(
          buttonName: 'retire_button',
          buttonType: ButtonType.alert,
          child: const Text('諦める'),
          onPressed: () async {
            await showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                final resultPage = quizType == QuizType.normal
                    ? const NormalQuizResultPage()
                    : const DailyQuizResultPage();

                return ConfirmDialog(
                  confirmText: quizType.retireConfirmText,
                  onPressedYes: () async {
                    final quizResultService =
                        ref.read(quizResultServiceProvider);

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
        ),
        MyButton(
          buttonName: 'try_again_button',
          buttonType: ButtonType.sub,
          onPressed: Navigator.of(context).pop,
          child: const Text('もう一度回答する'),
        ),
      ],
    );
  }
}
