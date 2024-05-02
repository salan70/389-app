import 'package:flutter/material.dart';

import '../../../core/common_widget/button/my_button.dart';
import '../../core/util/extension/context_extension.dart';

class IncorrectDialog extends StatelessWidget {
  const IncorrectDialog({
    super.key,
    required this.hitterName,
    required this.onTapRetire,
  });

  final String hitterName;

  /// 諦めるボタンを押した際の処理。
  final VoidCallback onTapRetire;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('残念...'),
      content: Text('$hitterName選手ではありません'),
      actions: <Widget>[
        MyButton(
          buttonName: 'retire_button',
          buttonType: ButtonType.alert,
          onPressed: onTapRetire,
          child: const Text('諦める'),
        ),
        MyButton(
          buttonName: 'try_again_button',
          buttonType: ButtonType.sub,
          onPressed: context.pop,
          child: const Text('もう一度回答する'),
        ),
      ],
    );
  }
}
