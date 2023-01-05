import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/setting.dart';
import '../../../../state/hitter_search_condition_state.dart';
import 'chose_team_view_model.dart';

class SettingStatsValueFilterWidget extends ConsumerWidget {
  const SettingStatsValueFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final notifier = ref.watch(hitterSearchConditionProvider.notifier);
    final viewModel = ref.watch(choseTeamViewModelProvider);

    return Column(
      children: [
        // 最低通算試合数
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('最低通算試合数'),
            const SizedBox(width: 16),
            DropdownButton<int>(
              items: statsFilterDropdownMenu(minGamesOptionList),
              onChanged: (int? value) {
                notifier.state = searchCondition.copyWith(minGames: value!);
              },
              value: searchCondition.minGames,
            ),
          ],
        ),
        // 最低通算打席数
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('最低通算ヒット数'),
            const SizedBox(width: 16),
            DropdownButton<int>(
              items: statsFilterDropdownMenu(minHitsOptionList),
              onChanged: (int? value) {
                notifier.state = searchCondition.copyWith(minHits: value!);
              },
              value: searchCondition.minHits,
            ),
          ],
        ),
        // 最低通算ホームラン数
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('最低通算ホームラン数'),
            const SizedBox(width: 16),
            DropdownButton<int>(
              items: statsFilterDropdownMenu(minHrOptionList),
              onChanged: (int? value) {
                notifier.state = searchCondition.copyWith(minHr: value!);
              },
              value: searchCondition.minHr,
            ),
          ],
        ),
      ],
    );
  }

  List<DropdownMenuItem<int>> statsFilterDropdownMenu(List<int> intItemList) {
    return intItemList
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text('$e'),
          ),
        )
        .toList();
  }
}
