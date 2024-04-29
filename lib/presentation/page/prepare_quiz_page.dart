import 'package:flutter/material.dart';

import '../component/common/back_to_top_button.dart';
import '../component/common/banner_ad_widget.dart';
import '../component/common/my_button.dart';
import '../component/quiz_setting/chose_team_widget.dart';
import '../component/quiz_setting/notes_text.dart';
import '../component/quiz_setting/select_stats_widget.dart';
import '../component/quiz_setting/stats_value_filter_widget.dart';
import '../component/quiz_setting/to_play_normal_quiz_from_prepare_button.dart';



class PrepareQuizPage extends StatelessWidget {
  const PrepareQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: const [
              BannerAdWidget(),
              SizedBox(height: 16),
              ChoseTeamWidget(),
              SizedBox(height: 16),
              StatsValueFilterWidget(),
              SizedBox(height: 16),
              SelectStatsWidget(),
              SizedBox(height: 16),
              NotesText(),
              SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: 160,
                  child: ToPlayNormalQuizFromPrepareButton(
                    buttonType: ButtonType.main,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: SizedBox(
                  width: 160,
                  child: BackToTopButton(buttonType: ButtonType.sub),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
