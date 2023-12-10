import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/my_button.dart';
import '../../../quiz/application/hitter_quiz_service.dart';
import '../../../quiz/presentation/play_quiz/play_normal_quiz/play_normal_quiz_page.dart';

class ToPlayNormalQuizFromTopButton extends ConsumerWidget {
  const ToPlayNormalQuizFromTopButton({
    super.key,
    required this.buttonType,
  });

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'to_play_normal_quiz_from_top_button',
      buttonType: buttonType,
      onPressed: () async {
        // 出題する選手を取得
        await ref
            .read(hitterQuizServiceProvider)
            .fetchHitterQuizBySearchCondition();

        if (context.mounted) {
          await Navigator.of(context).push(
            MaterialPageRoute<Widget>(
              builder: (_) => const PlayNormalQuizPage(),
              settings: const RouteSettings(
                name: '/play_normal_quiz_page',
              ),
            ),
          );
        }
      },
      child: FittedBox(
        child: Text(
          'クイズをプレイ！',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
          ),
        ),
      ),
    );
  }
}
