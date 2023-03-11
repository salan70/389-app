import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../util/constant/strings_constant.dart';
import '../../../component/banner_ad_widget.dart';
import '../../../component/quiz_widget.dart';
import '../../quiz_result/daily_quiz_result/daily_quiz_result_page.dart';
import '../component/quiz_event_buttons.dart';
import '../component/retire_button.dart';
import 'component/daily_quiz_answer_widget.dart';
import 'component/life_widget.dart';

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
                children: const [
                  BannerAdWidget(),
                  SizedBox(height: 16),
                  LifeWidget(),
                  SizedBox(height: 16),
                  QuizWidget(willRebuild: true),
                  SizedBox(height: 16),
                  QuizEventButtons(),
                  SizedBox(height: 16),
                  DailyQuizAnswerWidget(),
                  SizedBox(height: 16),
                  RetireButton(
                    retireConfirmText: dailyQuizRetireConfirmText,
                    resultPage: DailyQuizResultPage(),
                  ),
                  SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
