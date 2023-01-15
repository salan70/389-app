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
      appBar: AppBar(
        title: const Text('結果'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
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
