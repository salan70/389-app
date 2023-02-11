import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/hitter_search_condition_state.dart';
import '../../../../util/constant/hitter_search_condition_constant.dart';
import '../../../../util/constant/hitting_stats/stats_type.dart';
import '../prepare_quiz_view_model.dart';

class SelectStatsWidget extends ConsumerWidget {
  const SelectStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final selectedStatsList = searchCondition.selectedStatsList;
    final viewModel = ref.watch(prepareQuizViewModelProvider);

    return SmartSelect.multiple(
      title: '出題する成績',
      modalHeaderStyle: S2ModalHeaderStyle(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        errorStyle: TextStyle(
          color: Theme.of(context).errorColor,
        ),
      ),
      selectedValue: selectedStatsList,
      choiceItems: S2Choice.listFrom<String, void>(
        source: statsTypeList,
        value: (index, _) => statsTypeList[index].label,
        title: (index, _) => statsTypeList[index].label,
      ),
      modalType: S2ModalType.bottomSheet,
      choiceType: S2ChoiceType.chips,
      onChange: (selectedObject) {
        final selectedList = selectedObject.value as List<String>;
        viewModel.saveStatsList(selectedList);
      },
      // 返すテキストが空（''）の場合のみ、modalを閉じれる
      modalValidation: (chosen) {
        final isValid = viewModel.isValidSelectedStatsList(chosen.length);
        return isValid ? '' : errorForSelectStatsValidation;
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
              return Text(selectedStatsList[index]);
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
    final viewModel = ref.watch(prepareQuizViewModelProvider);
    final tappedStats = choice.value! as String;

    return Container(
      padding: const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: choice.selected
            ? Theme.of(context).primaryColor.withOpacity(0.2)
            : Theme.of(context).disabledColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: () {
          final isSelected = choice.selected;

          final canChangeState = viewModel.canChangeStatsState(
            selectedLength: state.selection!.length,
            isSelected: isSelected,
          );

          if (canChangeState) {
            choice.select?.call(!isSelected);
          }
        },
        child: Text(
          tappedStats,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
