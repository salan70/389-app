import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/hitting_stats/stats_type.dart';
import '../../../../state/hitter_search_condition_state.dart';
import 'chose_stats_type_view_model.dart';

class ChoseStatsTypeWidget extends ConsumerWidget {
  const ChoseStatsTypeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final selectedStatsList = searchCondition.selectedStatsList;

    return SmartSelect.multiple(
      title: '出題する成績',
      selectedValue: selectedStatsList,
      choiceItems: S2Choice.listFrom<StatsType, void>(
        source: statsTypeList,
        value: (index, item) => statsTypeList[index],
        title: (index, item) => statsTypeList[index].label,
      ),
      modalType: S2ModalType.bottomSheet,
      choiceType: S2ChoiceType.chips,
      onChange: (selectedList) {
        // viewModel.saveTeamList(selectedList.value);
      },
      tileBuilder: (context, state) {
        return S2Tile.fromState(
          state,
          hideValue: true,
          body: S2TileChips(
            chipColor: Theme.of(context).primaryColor,
            chipLength: selectedStatsList.length,
            chipLabelBuilder: (context, index) {
              return Text(selectedStatsList[index].label);
            },
            // chipOnDelete: viewModel.removeTeam,
            placeholder: Container(),
          ),
        );
      },
      choiceBuilder: (context, state, choice) {
        final selectedStats = choice.value! as StatsType;
        return ChoiceCard(selectedStats: selectedStats);
      },
    );
  }
}

class ChoiceCard extends ConsumerWidget {
  const ChoiceCard({
    super.key,
    required this.selectedStats,
  });

  final StatsType selectedStats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final viewModel = ref.watch(choseStatsTypeViewModelProvider);

    final selectedStatsList = searchCondition.selectedStatsList;

    return Card(
      child: InkWell(
        onTap: () {
          // TODO(me): addかremoveか判別する関数実装
          // TODO(me): addする関数実装
          // TODO(me): removeする関数実装
          // TODO(me): 5個までしか登録できない関数実行（年度あわせて）
          viewModel.addStats(selectedStats);
        },
        child: Container(
          padding: const EdgeInsets.all(7),
          color: selectedStatsList.contains(selectedStats) ? Colors.blue : null,
          child: Text(
            selectedStats.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
