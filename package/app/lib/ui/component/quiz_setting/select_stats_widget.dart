import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:model/model.dart';

class SelectStatsWidget extends StatelessWidget {
  const SelectStatsWidget({
    super.key,
    required this.selectedStatsList,
    required this.onChange,
    required this.isValidSelectedStatsList,
    required this.canChangeStatsState,
  });

  /// 選択中の「出題する成績」。
  final List<String> selectedStatsList;

  /// 「出題する成績」が更新された際の処理。
  final void Function(List<String>) onChange;

  /// 「出題する成績」が有効かどうかを判別する処理。
  final bool Function(int) isValidSelectedStatsList;

  /// 新たに「出題する成績」を選択できるかどうかを判別する処理。
  final bool Function({
    required int selectedLength,
    required bool isSelected,
  }) canChangeStatsState;

  @override
  Widget build(BuildContext context) {
    return SmartSelect.multiple(
      title: '出題する成績',
      modalHeaderStyle: S2ModalHeaderStyle(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
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
        final selectedList = selectedObject.value;
        onChange(selectedList);
      },
      // 返すテキストが空（''）の場合のみ、modalを閉じれる
      modalValidation: (chosen) {
        final isValid = isValidSelectedStatsList(chosen.length);
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
        return _ChoiceCard(
          state: state,
          choice: choice,
          canChangeStatsState: canChangeStatsState,
        );
      },
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.state,
    required this.choice,
    required this.canChangeStatsState,
  });

  final S2MultiState<Object?> state;
  final S2Choice<Object?> choice;

  final bool Function({
    required int selectedLength,
    required bool isSelected,
  }) canChangeStatsState;

  @override
  Widget build(BuildContext context) {
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

          final canChangeState = canChangeStatsState(
            selectedLength: state.selection!.length,
            isSelected: isSelected,
          );

          if (canChangeState) {
            choice.select?.call(!isSelected);
          }
        },
        child: Text(
          choice.value! as String,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
