import 'package:baseball_quiz_app/common_widget/my_button.dart';
import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key, required this.isMain});

  final bool isMain;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      isMain: isMain,
      onPressed: Navigator.of(context).pop,
      child: const Text('戻る'),
    );
  }
}
