import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textfield_search/textfield_search.dart';

import 'input_answer_view_model.dart';

class InputAnswer extends ConsumerWidget {
  const InputAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ScrollController();
    final textEditingController = TextEditingController();
    final viewModel = ref.watch(inputAnswerViewModelProvider);

    return TextFieldSearch(
        label: '選手名',
        controller: textEditingController,
        minStringLength: 0,
        itemsInView: 5,
        scrollbarDecoration: ScrollbarDecoration(
          controller: scrollController,
          theme: const ScrollbarThemeData(),
        ),
        future: () async {
          return await viewModel.searchHitter(textEditingController.text);
        },
        getSelectedValue: (value) {
          // TODO 選択しているvalueをセット
          print(value);
        });
  }
}
