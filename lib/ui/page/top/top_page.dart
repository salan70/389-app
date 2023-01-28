import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../component/admob_widget.dart';
import 'component/to_play_quiz_from_top_widget.dart';
import 'component/to_prepare_quiz_button_widget.dart';
import 'component/to_setting_button_widget.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, top: 100, right: 40),
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
                      SizedBox(height: 8),
                      ToPlayQuizFromTopWidget(),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: BannerAdWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
