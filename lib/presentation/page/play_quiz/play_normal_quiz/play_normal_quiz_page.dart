import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../component/banner_ad_widget.dart';
import '../../../component/quiz_widget.dart';
import '../../quiz_result/normal_quiz_result/normal_quiz_result_page.dart';
import '../component/answer_widget.dart';
import '../component/quiz_event_buttons.dart';
import '../component/retire_button.dart';

class PlayNormalQuizPage extends StatelessWidget {
  const PlayNormalQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    const normalQuizRetireConfirmText = '本当に諦めますか？';

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
                SizedBox(height: 16),
                QuizEventButtons(),
                SizedBox(height: 16),
                AnswerWidget(
                  retireConfirmText: normalQuizRetireConfirmText,
                  maxCanIncorrectCount: null,
                  resultPage: NormalQuizResultPage(),
                ),
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
