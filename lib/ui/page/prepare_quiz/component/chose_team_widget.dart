import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/team_list.dart';
import '../../../../state/hitter_search_condition_state.dart';
import 'chose_team_view_model.dart';

class ChoseTeamWidget extends ConsumerWidget {
  const ChoseTeamWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamList = ref.watch(hitterSearchConditionProvider).teamList;
    final viewModel = ref.watch(choseTeamViewModelProvider);

    return SmartSelect.multiple(
      title: '球団',
      selectedValue: teamList,
      choiceGrouped: true,
      choiceItems: S2Choice.listFrom<String, Map<String, String>>(
        source: defaultTeamList,
        value: (index, item) => item['name']!,
        title: (index, item) => item['name']!,
        group: (index, item) => item['league']!,
      ),
      modalType: S2ModalType.bottomSheet,
      choiceType: S2ChoiceType.chips,
      onChange: (selectedList) {
        viewModel.saveTeamList(selectedList.value);
      },
      tileBuilder: (context, state) {
        return S2Tile.fromState(
          state,
          hideValue: true,
          body: S2TileChips(
            chipColor: Theme.of(context).primaryColor,
            chipLength: teamList.length,
            chipLabelBuilder: (context, index) {
              return Text(teamList[index]);
            },
            chipOnDelete: (index) {
              if (viewModel.canRemoveTeam()) {
                viewModel.removeTeam(index);
              }
            },
          ),
        );
      },
    );
  }
}
