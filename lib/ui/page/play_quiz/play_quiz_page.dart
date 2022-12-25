import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'component/input_answer_widget.dart';
import 'component/quiz_event_buttons_widget.dart';
import 'component/quiz_widget.dart';

class PlayQuizPage extends ConsumerWidget {
  const PlayQuizPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('プレイ'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: const [
              QuizWidget(),
              QuizEventButtonsWidget(),
              InputAnswerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
