import 'package:flutter/material.dart';
import 'package:model/model.dart';
import 'package:textfield_search/textfield_search.dart';

class InputAnswerTextField extends StatelessWidget {
  InputAnswerTextField({
    super.key,
    required this.textEditingController,
    required this.onSearchHitter,
    required this.onSelectedHitter,
    required this.showErrorText,
  });

  /// 回答入力用に使用する [TextEditingController].
  ///
  /// リビルドしても入力した文字列が保持されるように、親の Widget で管理する。
  final TextEditingController textEditingController;

  /// 選手検索時の処理。
  ///
  /// 戻り値で [List<Hitter>] を指定すること。
  final Future<List<Hitter>> Function() onSearchHitter;

  /// 検索結果のリストの中から、選手を選択した際の処理。
  final void Function(Hitter value) onSelectedHitter;

  /// 入力を促すエラーメッセージを表示するかどうか。
  final bool showErrorText;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldSearch(
          label: '選手名',
          controller: textEditingController,
          minStringLength: 0,
          itemsInView: 5,
          scrollbarDecoration: ScrollbarDecoration(
            controller: _scrollController,
            theme: const ScrollbarThemeData(),
          ),
          future: onSearchHitter,
          getSelectedValue: onSelectedHitter,
        ),
        // エラーメッセージ
        if (showErrorText)
          Text(
            '選手を入力して下さい...！',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
      ],
    );
  }
}
