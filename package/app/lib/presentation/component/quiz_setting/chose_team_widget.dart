import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature/search_condition/application/search_condition_notifier.dart';
import '../../../../feature/search_condition/util/search_condition_constant.dart';
import '../../../../util/constant/strings_constant.dart';

class ChoseTeamWidget extends ConsumerWidget {
  const ChoseTeamWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamList = ref.watch(searchConditionNotifierProvider).teamList;

    final notifier = ref.watch(searchConditionNotifierProvider.notifier);

    return SmartSelect.multiple(
      title: '球団',
      selectedValue: teamList,
      choiceGrouped: true,
      choiceItems: S2Choice.listFrom<String, Map<String, String>>(
        source: npbTeamList,
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
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      groupHeaderStyle: S2GroupHeaderStyle(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      onChange: (selectedList) => notifier.updateTeamList(selectedList.value),
      // 返すテキストが空（''）の場合のみ、modalを閉じれる
      modalValidation: (chosen) {
        final isValid = notifier.isValidTeamList(chosen.length);
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
              if (notifier.canRemoveTeam()) {
                notifier.removeTeam(index);
              }
            },
          ),
        );
      },
    );
  }
}
