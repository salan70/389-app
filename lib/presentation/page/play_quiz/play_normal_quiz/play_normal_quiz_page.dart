import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../util/constant/text_in_app.dart';
import '../../../component/banner_ad_widget.dart';
import '../../../component/quiz_widget.dart';
import '../../quiz_result/normal_quiz_result/normal_quiz_result_page.dart';
import '../component/quiz_event_buttons.dart';
import '../component/retire_button.dart';
import 'component/normal_quiz_answer_widget.dart';

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
              children: const [
                BannerAdWidget(),
                SizedBox(height: 16),
                QuizWidget(willRebuild: true),
                SizedBox(height: 16),
                QuizEventButtons(),
                SizedBox(height: 16),
                NormalQuizAnswerWidget(),
                SizedBox(height: 16),
                RetireButton(
                  retireConfirmText: normalQuizRetireConfirmText,
                  resultPage: NormalQuizResultPage(),
                ),
                SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
