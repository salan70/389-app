import 'package:flutter/material.dart';

import '../../../../../feature/search_condition/presentation/prepare_quiz_page.dart';

class RePrepareQuizButton extends StatelessWidget {
  const RePrepareQuizButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => const PrepareQuizPage(),
          ),
        );
      },
      child: const Text('条件を再設定'),
    );
  }
}
