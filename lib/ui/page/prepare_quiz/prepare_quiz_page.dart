import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repository/hitter_search_condition_repository.dart';
import '../../../state/hitter_search_condition_state.dart';
import 'component/chose_team_widget.dart';
import 'component/select_stats_widget.dart';
import 'component/setting_stats_value_filter_widget.dart';
import 'component/to_play_quiz_button_widget.dart';

class PrepareQuizPage extends ConsumerWidget {
  const PrepareQuizPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterSearchCondition = ref.watch(hitterSearchConditionProvider);
    final hitterSearchConditionRepository =
        ref.watch(hitterSearchConditionRepositoryProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('プレイ'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: const [
              ChoseTeamWidget(),
              SettingStatsValueFilterWidget(),
              SelectStatsWidget(),
              ToPlayQuizButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
