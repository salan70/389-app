import 'package:baseball_quiz_app/feature/quiz/presentation/play_quiz/component/input_answer_text_field.dart';
import 'package:baseball_quiz_app/feature/quiz/presentation/play_quiz/play_daily_quiz/daily_quiz_submit_answer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../admob/presentation/banner_ad_widget.dart';
import '../../component/quiz_widget.dart';
import '../component/quiz_event_buttons.dart';
import '../component/retire_button.dart';
import 'life_widget.dart';

class PlayDailyQuizPage extends StatelessWidget {
  const PlayDailyQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                  const LifeWidget(),
                  const SizedBox(height: 16),
                  const QuizWidget(willRebuild: true),
                  const SizedBox(height: 16),
                  const QuizEventButtons(),
                  const SizedBox(height: 16),
                  InputAnswerTextField(),
                  const SizedBox(height: 16),
                  const DailyQuizSubmitAnswerButton(isMain: true),
                  const SizedBox(height: 16),
                  const RetireButton(),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
