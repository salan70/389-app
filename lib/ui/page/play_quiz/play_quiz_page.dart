import 'package:flutter/material.dart';

import '../../component/quiz_widget.dart';
import 'component/answer_widget.dart';
import 'component/quiz_event_buttons_widget.dart';
import 'component/retire_button_widget.dart';

class PlayQuizPage extends StatelessWidget {
  const PlayQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: const [
            QuizWidget(),
            QuizEventButtonsWidget(),
            AnswerWidget(),
            RetireButtonWidget(),
          ],
        ),
      ),
    );
  }
}
