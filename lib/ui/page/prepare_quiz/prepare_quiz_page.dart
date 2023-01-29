import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../component/admob_widget.dart';
import 'component/chose_team_widget.dart';
import 'component/notes_widget.dart';
import 'component/select_stats_widget.dart';
import 'component/setting_stats_value_filter_widget.dart';
import 'component/to_play_quiz_button_widget.dart';

class PrepareQuizPage extends StatelessWidget {
  const PrepareQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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
              SettingStatsValueFilterWidget(),
              SizedBox(height: 16),
              SelectStatsWidget(),
              SizedBox(height: 16),
              ToPlayQuizButtonWidget(),
              SizedBox(height: 16),
              NotesWidget(),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
