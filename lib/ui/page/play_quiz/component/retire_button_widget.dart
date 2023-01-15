import 'package:flutter/material.dart';

import '../../quiz_result/quiz_result_page.dart';

class RetireButtonWidget extends StatelessWidget {
  const RetireButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => const QuizResultPage(),
          ),
        );
      },
      child: const Text('諦める'),
    );
  }
}
