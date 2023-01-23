import 'package:flutter/material.dart';

import '../prepare_quiz/component/to_play_quiz_button_widget.dart';
import 'component/to_prepare_quiz_button_widget.dart';
import 'component/to_setting_button_widget.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, top: 80, right: 8, bottom: 8),
        child: Center(
          child: Column(
            children: const [
              ToSettingButtonWidget(),
              ToPrepareQuizButtonWidget(),
              ToPlayQuizButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
