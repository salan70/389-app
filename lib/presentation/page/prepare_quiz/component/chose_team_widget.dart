import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/quiz/search_condition/search_condition_service.dart';
import '../../../../application/quiz/search_condition/search_condition_state.dart';
import '../../../../util/constant/search_condition_constant.dart';
import '../../../../util/constant/team_list.dart';

class ChoseTeamWidget extends ConsumerWidget {
  const ChoseTeamWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamList = ref.watch(searchConditionProvider).teamList;
    final searchConditionService = ref.watch(searchConditionServiceProvider);

    return SmartSelect.multiple(
      title: '球団',
      selectedValue: teamList,
      choiceGrouped: true,
      choiceItems: S2Choice.listFrom<String, Map<String, String>>(
        source: defaultTeamList,
        value: (_, item) => item['name']!,
        title: (_, item) => item['name']!,
        group: (_, item) => item['league']!,
      ),
      modalType: S2ModalType.bottomSheet,
      choiceType: S2ChoiceType.chips,
      choiceStyle: const S2ChoiceStyle(
        showCheckmark: false,
      ),
      modalStyle: S2ModalStyle(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      modalHeaderStyle: S2ModalHeaderStyle(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        errorStyle: TextStyle(
          color: Theme.of(context).errorColor,
        ),
      ),
      groupHeaderStyle: S2GroupHeaderStyle(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      onChange: (selectedList) {
        searchConditionService.saveTeamList(selectedList.value);
      },
      // 返すテキストが空（''）の場合のみ、modalを閉じれる
      modalValidation: (chosen) {
        final isValid =
            searchConditionService.isValidChoseTeamList(chosen.length);
        return isValid ? '' : errorForChoseTeamValidation;
      },
      tileBuilder: (context, state) {
        return S2Tile.fromState(
          state,
          hideValue: true,
          body: S2TileChips(
            chipColor: Theme.of(context).primaryColor,
            chipLength: teamList.length,
            chipLabelBuilder: (_, index) {
              return Text(teamList[index]);
            },
            chipOnDelete: (index) {
              if (searchConditionService.canRemoveTeam()) {
                searchConditionService.removeTeam(index);
              }
            },
          ),
        );
      },
    );
  }
}
