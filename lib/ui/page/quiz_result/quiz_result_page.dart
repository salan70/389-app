import 'package:flutter/material.dart';

import '../../component/quiz_widget.dart';
import 'component/navigation_buttons_widget.dart';
import 'component/result_text_widget.dart';
import 'component/share_button_widget.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, top: 80, right: 8, bottom: 8),
        child: Column(
          children: const [
            ResultTextWidget(),
            QuizWidget(),
            NavigationButtonsWidget(),
            ShareButtonWidget(),
          ],
        ),
      ),
    );
  }
}
