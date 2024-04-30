import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/button/my_button.dart';
import '../../../core/common_widget/dialog/confirm_dialog.dart';
import '../../core/router/app_router.dart';

class IncorrectDialog extends ConsumerWidget {
  const IncorrectDialog.normal({super.key, required this.hitterName})
      : quizType = QuizType.normal,
        questionedAt = null;

  const IncorrectDialog.daily({
    super.key,
    required this.hitterName,
    required this.questionedAt,
  }) : quizType = QuizType.daily;

  final String hitterName;
  final QuizType quizType;

  /// 対象となる DailyQuiz の出題日。
  ///
  /// [QuizType.daily] の場合、必須。
  final DateTime? questionedAt;

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
                return ConfirmDialog(
                  confirmText: quizType.retireConfirmText,
                  onPressedYes: () async {
                    final quizResultService =
                        ref.read(quizResultServiceProvider);

                    // * 通常クイズの場合
                    if (quizType == QuizType.normal) {
                      await quizResultService.createNormalQuizResult();
                      if (context.mounted) {
                        await context.pushRoute(NormalQuizResultRoute());
                      }
                      return;
                    }

                    // * デイリークイズの場合
                    if (questionedAt == null) {
                      throw ArgumentError.notNull('questionedAt');
                    }
                    await quizResultService
                        .updateDailyQuizResult(questionedAt!);

                    if (context.mounted) {
                      await context.pushRoute(
                        DailyQuizResultRoute(questionedAt: questionedAt!),
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
          onPressed: context.popRoute,
          child: const Text('もう一度回答する'),
        ),
      ],
    );
  }
}
