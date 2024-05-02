import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/button/my_button.dart';
import '../../../core/common_widget/dialog/confirm_dialog.dart';
import '../../core/router/app_router.dart';

class RetireButton extends ConsumerWidget {
  const RetireButton.normal({
    super.key,
    required this.buttonType,
  })  : quizType = QuizType.normal,
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
          builder: (_) => ConfirmDialog(
            confirmText: quizType.retireConfirmText,
            onPressedYes: () async {
              final quizResultService = ref.read(quizResultServiceProvider);

              // * 通常クイズの場合
              if (quizType == QuizType.normal) {
                await quizResultService.createNormalQuizResult();
                if (context.mounted) {
                  await context.pushRoute(ResultNormalQuizRoute());
                }
                return;
              }

              // * デイリークイズの場合
              if (questionedAt == null) {
                throw ArgumentError.notNull('questionedAt');
              }
              await quizResultService.updateDailyQuizResult(questionedAt!);

              if (context.mounted) {
                await context.pushRoute(
                  ResultDailyQuizRoute(questionedAt: questionedAt!),
                );
              }
            },
          ),
        );
      },
      child: const Text('諦める'),
    );
  }
}
