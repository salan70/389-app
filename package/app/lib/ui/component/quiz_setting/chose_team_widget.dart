import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:model/model.dart';

class ChoseTeamWidget extends StatelessWidget {
  const ChoseTeamWidget({
    super.key,
    required this.teamList,
    required this.onChange,
    required this.isValidTeamList,
    required this.chipOnDelete,
  });

  /// 選択対象の球団名の List.
  final List<String> teamList;

  /// 選択中の球団を更新した際の処理。
  final void Function(List<Object?>) onChange;

  /// 選択中の球団リストが有効かどうか。
  final bool Function(int) isValidTeamList;

  /// 選択中の球団を外した（選択外にした）際の処理。
  final void Function(int) chipOnDelete;

  @override
  Widget build(BuildContext context) {
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
      onChange: (selectedList) => onChange(selectedList.value),
      // 返すテキストが空（''）の場合のみ、 modal を閉じれる
      modalValidation: (chosen) {
        final isValid = isValidTeamList(chosen.length);
        return isValid ? '' : errorForChoseTeamValidation;
      },
      tileBuilder: (context, state) => S2Tile.fromState(
        state,
        hideValue: true,
        body: S2TileChips(
          chipColor: Theme.of(context).primaryColor,
          chipLength: teamList.length,
          chipLabelBuilder: (_, index) => Text(teamList[index]),
          chipOnDelete: chipOnDelete,
        ),
      ),
    );
  }
}
