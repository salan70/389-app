import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/hitter_search_condition_state.dart';
import 'chose_team_view_model.dart';

class SettingStatsValueFilterWidget extends ConsumerWidget {
  const SettingStatsValueFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final viewModel = ref.watch(choseTeamViewModelProvider);

    return Column(
      children: [],
    );
  }
}
