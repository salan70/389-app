import 'package:flutter/material.dart';

import '../../../core/util/extension/context_extension.dart';
import '../common/button/my_button.dart';

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
        // 下記エラーを回避するため、 Builder でラップしている。
        // `A TextEditingController was used after being disposed.`
        Builder(
          builder: (context) {
            return MyButton(
              buttonName: 'retire_button',
              buttonType: ButtonType.alert,
              onPressed: () {
                onTapRetire();
                context.pop();
              },
              child: const Text('諦める'),
            );
          },
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
