import 'package:flutter/material.dart';

import 'component/to_play_quiz_from_top_widget.dart';
import 'component/to_prepare_quiz_button_widget.dart';
import 'component/to_setting_button_widget.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 40, top: 160, right: 40, bottom: 160),
          child: Center(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: ToSettingButtonWidget(),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ToPrepareQuizButtonWidget(),
                      ToPlayQuizFromTopWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
