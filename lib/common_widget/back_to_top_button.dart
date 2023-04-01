import 'package:baseball_quiz_app/common_widget/my_button.dart';
import 'package:flutter/material.dart';

class BackToTopButton extends StatelessWidget {
  const BackToTopButton({super.key, required this.isMain});

  final bool isMain;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      isMain: isMain,
      onPressed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: const Text('TOPへ戻る'),
    );
  }
}
