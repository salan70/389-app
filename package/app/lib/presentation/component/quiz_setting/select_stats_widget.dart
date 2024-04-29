import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

class SelectStatsWidget extends ConsumerWidget {
  const SelectStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatsList =
        ref.watch(searchConditionNotifierProvider).selectedStatsList;

    final notifier = ref.watch(searchConditionNotifierProvider.notifier);

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
        final selectedList = selectedObject.value as List<String>;
        notifier.updateSelectedStatsList(selectedList);
      },
      // 返すテキストが空（''）の場合のみ、modalを閉じれる
      modalValidation: (chosen) {
        final isValid = notifier.isValidSelectedStatsList(chosen.length);
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
        return _ChoiceCard(state: state, choice: choice);
      },
    );
  }
}

class _ChoiceCard extends ConsumerWidget {
  const _ChoiceCard({
    required this.state,
    required this.choice,
  });

  final S2MultiState<Object?> state;
  final S2Choice<Object?> choice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

          final canChangeState = ref
              .read(searchConditionNotifierProvider.notifier)
              .canChangeStatsState(
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
