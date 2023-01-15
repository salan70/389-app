import 'package:baseball_quiz_app/main.dart';
import 'package:flutter/material.dart';

import '../../component/quiz_widget.dart';
import 'component/input_answer_widget.dart';
import 'component/quiz_event_buttons_widget.dart';

class PlayQuizPage extends StatelessWidget {
  const PlayQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プレイ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            const QuizWidget(),
            const QuizEventButtonsWidget(),
            const InputAnswerWidget(),
            // TODO(me): 諦めるボタンにする（componentに）
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (_) => const MyApp(),
                  ),
                );
              },
              child: const Text('TOPへ戻る'),
            ),
          ],
        ),
      ),
    );
  }
}
