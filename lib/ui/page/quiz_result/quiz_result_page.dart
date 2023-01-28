import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../component/admob_widget.dart';
import 'component/navigation_buttons_widget.dart';
import 'component/replay_button_widget.dart';
import 'component/result_quiz_widget.dart';
import 'component/result_text_widget.dart';
import 'component/share_button_widget.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    // TODO(me): globalKeyを引数として渡すのイケてない感ある
    // 本当はProviderで参照したかった。。
    final globalKey = GlobalKey();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: ListView(
            children: [
              const BannerAdWidget(),
              const SizedBox(height: 16),
              const ResultTextWidget(),
              const SizedBox(height: 16),
              ResultQuizWidget(globalKey: globalKey),
              const SizedBox(height: 8),
              const ReplayButtonWidget(),
              const SizedBox(height: 8),
              ShareButtonWidget(globalKey: globalKey),
              const SizedBox(height: 8),
              const NavigationButtonsWidget(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
