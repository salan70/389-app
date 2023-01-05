import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repository/hitter_search_condition_repository.dart';
import '../../../state/hitter_search_condition_state.dart';
import '../play_quiz/play_quiz_page.dart';
import 'component/chose_stats_type_widget.dart';
import 'component/chose_team_widget.dart';
import 'component/setting_stats_value_filter_widget.dart';

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
            children: [
              const ChoseTeamWidget(),
              const SettingStatsValueFilterWidget(),
              const ChoseStatsTypeWidget(),
              TextButton(
                onPressed: () {
                  // hitterSearchConditionをローカルDBへ保存
                  hitterSearchConditionRepository
                      .saveHitterSearchCondition(hitterSearchCondition);

                  // 画面遷移
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => const PlayQuizPage(),
                    ),
                  );
                },
                child: const Text('クイズへ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
