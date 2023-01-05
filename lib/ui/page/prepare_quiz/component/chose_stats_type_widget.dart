import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/hitter_search_condition_constant.dart';
import '../../../../constant/hitting_stats/stats_type.dart';
import '../../../../state/hitter_search_condition_state.dart';
import 'chose_stats_type_view_model.dart';

class ChoseStatsTypeWidget extends ConsumerWidget {
  const ChoseStatsTypeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final selectedStatsList = searchCondition.selectedStatsList;
    final viewModel = ref.watch(choseStatsTypeViewModelProvider);

    return SmartSelect.multiple(
      title: '出題する成績',
      modalHeaderStyle: S2ModalHeaderStyle(
        errorStyle: TextStyle(
          color: Theme.of(context).errorColor,
        ),
      ),
      selectedValue: selectedStatsList,
      choiceItems: S2Choice.listFrom<StatsType, void>(
        source: statsTypeList,
        value: (index, _) => statsTypeList[index],
        title: (index, _) => statsTypeList[index].label,
      ),
      modalType: S2ModalType.bottomSheet,
      choiceType: S2ChoiceType.chips,
      onChange: (selectedObject) {
        final selectedList = selectedObject.value as List<StatsType>;
        viewModel.saveStatsList(selectedList);
      },
      // 返すテキストが空（''）の場合のみ、modalを閉じれる
      modalValidation: (chosen) {
        final isValid = viewModel.isValidSelectedStatsList(chosen.length);
        return isValid ? '' : errorForSelectStatsTypeValidation;
      },
      // modal表示前画面の、選択している成績のUI
      tileBuilder: (context, state) {
        return S2Tile.fromState(
          state,
          hideValue: true,
          body: S2TileChips(
            chipColor: Theme.of(context).primaryColor,
            chipLength: selectedStatsList.length,
            chipLabelBuilder: (_, index) {
              return Text(selectedStatsList[index].label);
            },
          ),
        );
      },
      // modal内の成績のUI
      choiceBuilder: (_, state, choice) {
        return ChoiceCard(state: state, choice: choice);
      },
    );
  }
}

class ChoiceCard extends ConsumerWidget {
  const ChoiceCard({
    super.key,
    required this.state,
    required this.choice,
  });

  final S2MultiState<Object?> state;
  final S2Choice<Object?> choice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(choseStatsTypeViewModelProvider);
    final tappedStats = choice.value! as StatsType;

    return Card(
      child: InkWell(
        onTap: () {
          final isSelected = choice.selected;

          final canChangeState = viewModel.canChangeState(
            selectedLength: state.selection!.length,
            isSelected: isSelected,
          );

          if (canChangeState) {
            choice.select?.call(!isSelected);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(7),
          color: choice.selected ? Colors.blue : null,
          child: Text(
            tappedStats.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
