import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/team_list.dart';
import '../../../../state/hitter_search_condition_state.dart';

class ChoseTeamWidget extends ConsumerWidget {
  const ChoseTeamWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final notifier = ref.watch(hitterSearchConditionProvider.notifier);

    return SmartSelect.multiple(
      title: '球団',
      placeholder: 'タップして選択',
      selectedValue: searchCondition.teamList,
      choiceGrouped: true,
      choiceItems: S2Choice.listFrom<String, Map<String, String>>(
        source: teamList,
        value: (index, item) => item['name']!,
        title: (index, item) => item['name']!,
        group: (index, item) => item['league']!,
      ),
      modalType: S2ModalType.bottomSheet,
      choiceType: S2ChoiceType.chips,
      onChange: (selectedList) {
        // TODO: ViewModelで書く
        final teamList = selectedList.value.cast<String>();
        notifier.state = searchCondition.copyWith(teamList: teamList);
      },
    );
  }
}
