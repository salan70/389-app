import 'package:baseball_quiz_app/application/user/user_service.dart';
import 'package:baseball_quiz_app/util/constant/hitting_stats_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/quiz/hitter_quiz/hitter_quiz_state.dart';
import '../../../../util/constant/strings_constant.dart';
import '../../../component/confirm_dialog.dart';
import '../../quiz_result/daily_quiz_result/daily_quiz_result_page.dart';
import '../../quiz_result/normal_quiz_result/normal_quiz_result_page.dart';

class RetireButton extends ConsumerWidget {
  const RetireButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuiz = ref.watch(hitterQuizStateProvider);

    return hitterQuiz.maybeWhen(
      orElse: Container.new,
      data: (data) {
        final quizType = data!.quizType;
        return Center(
          child: SizedBox(
            width: 120,
            child: TextButton(
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
                        final userService = ref.read(userServiceProvider);

                        if (quizType == QuizType.normal) {
                          await userService.createNormalQuizResult();
                        } else {
                          await userService.updateDailyQuizResult();
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
              child: const Text('諦める'),
            ),
          ),
        );
      },
    );
  }
}
