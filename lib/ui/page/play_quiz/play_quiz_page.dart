import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../component/admob_widget.dart';
import '../../component/quiz_widget.dart';
import 'component/answer_widget.dart';
import 'component/quiz_event_buttons_widget.dart';
import 'component/retire_button_widget.dart';

class PlayQuizPage extends StatelessWidget {
  const PlayQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            behavior: HitTestBehavior.opaque,
            child: ListView(
              children: const [
                BannerAdWidget(),
                SizedBox(height: 16),
                QuizWidget(willUpdate: true),
                QuizEventButtonsWidget(),
                AnswerWidget(),
                RetireButtonWidget(),
                SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
