import 'package:flutter/material.dart';

import '../common/button/my_button.dart';

class QuizEventButtons extends StatelessWidget {
  const QuizEventButtons({
    super.key,
    required this.onOpenAll,
    required this.onOpenSingle,
  });

  /// 全ての成績を表示するボタンが押された際の処理。
  final VoidCallback onOpenAll;

  /// 成績を1つ表示するボタンが押された際の処理。
  final VoidCallback onOpenSingle;

  static const _buttonWidth = 160.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: _buttonWidth,
          child: MyButton(
            buttonName: 'show_all_stat_button',
            buttonType: ButtonType.sub,
            onPressed: onOpenAll,
            child: const Text('全ての成績を表示'),
          ),
        ),
        SizedBox(
          width: _buttonWidth,
          child: MyButton(
            buttonName: 'show_next_stat_button',
            buttonType: ButtonType.sub,
            onPressed: onOpenSingle,
            child: const Text('次の成績を表示'),
          ),
        ),
      ],
    );
  }
}
