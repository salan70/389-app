import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/confirm_dialog.dart';
import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../../../util/constant/strings_constant.dart';
import '../../../../quiz_result/application/quiz_result_service.dart';
import '../../../application/answer_state.dart';
import '../../../application/hitter_quiz_state.dart';
import '../../quiz_result/daily_quiz_result/daily_quiz_result_page.dart';
import '../../quiz_result/normal_quiz_result/normal_quiz_result_page.dart';

class IncorrectDialog extends ConsumerWidget {
  const IncorrectDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuiz = ref.watch(hitterQuizStateProvider);
    final submittedHitter = ref.watch(submittedHitterProvider);

    return hitterQuiz.maybeWhen(
      orElse: Container.new,
      data: (data) {
        final quizType = data!.quizType;
        return AlertDialog(
          title: const Text('残念...'),
          // submittedHitterがnullの場合、このダイアログは表示されない想定
          content: Text('${submittedHitter!.label}選手ではありません}'),
          actions: <Widget>[
            TextButton(
              child: Text(
                '諦める',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onPressed: () async {
                await showDialog<void>(
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
            ),
            TextButton(
              child: const Text('もう一度回答する'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
