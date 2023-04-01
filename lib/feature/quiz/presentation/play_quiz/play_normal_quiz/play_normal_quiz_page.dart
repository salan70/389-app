import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../admob/presentation/banner_ad_widget.dart';
import '../../component/quiz_widget.dart';
import '../component/input_answer_text_field.dart';
import '../component/quiz_event_buttons.dart';
import '../component/retire_button.dart';
import 'normal_quiz_submit_answer_button.dart';

class PlayNormalQuizPage extends StatelessWidget {
  const PlayNormalQuizPage({super.key});

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
              children: [
                const BannerAdWidget(),
                const SizedBox(height: 16),
                const QuizWidget(willRebuild: true),
                const SizedBox(height: 16),
                const QuizEventButtons(),
                const SizedBox(height: 16),
                InputAnswerTextField(),
                const SizedBox(height: 16),
                const NormalQuizSubmitAnswerButton(isMain: true),
                const RetireButton(),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
