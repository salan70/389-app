import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../admob/presentation/banner_ad_widget.dart';
import '../../daily_quiz/presentation/to_play_daily_quiz_button.dart';
import 'component/icon_widget.dart';
import 'component/to_gallery_button.dart';
import 'component/to_play_normal_quiz_from_top_button.dart';
import 'component/to_prepare_quiz_button.dart';
import 'component/to_setting_button.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    const buttonWidth = 240.0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, top: 100, right: 40),
          child: Center(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 120,
                    child: ToSettingButton(isMain: false),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: const [
                      SizedBox(height: 48),
                      IconWidget(),
                      SizedBox(height: 40),
                      SizedBox(
                        width: buttonWidth,
                        child: ToPrepareQuizButton(isMain: false),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: buttonWidth,
                        child: ToPlayNormalQuizFromTopButton(isMain: true),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: buttonWidth,
                        child: ToPlayDailyQuizButton(isMain: false),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: buttonWidth,
                        child: ToGalleryButton(isMain: false),
                      ),
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
