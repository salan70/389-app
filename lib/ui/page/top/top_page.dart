import 'package:flutter/material.dart';

import '../prepare_quiz/prepare_quiz_page.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, top: 80, right: 8, bottom: 8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text('クイズの設定をする'),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => const PrepareQuizPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
