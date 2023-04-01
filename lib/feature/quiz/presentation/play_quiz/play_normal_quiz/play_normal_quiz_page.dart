import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../util/constant/button_type_constant.dart';
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
    const buttonWidth = 160.0;

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
                InputAnswerTextField(),
                const SizedBox(height: 16),
                const QuizEventButtons(),
                const SizedBox(height: 16),
                const Center(
                  child: SizedBox(
                    width: buttonWidth,
                    child: NormalQuizSubmitAnswerButton(
                      buttonType: ButtonType.main,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: SizedBox(
                    width: buttonWidth,
                    child: RetireButton(buttonType: ButtonType.sub),
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
