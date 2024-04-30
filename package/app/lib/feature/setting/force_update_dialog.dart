import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/button/my_button.dart';

/// エラーを知らせるダイアログ
class ForceUpdateDialog extends ConsumerWidget {
  const ForceUpdateDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(
        'お知らせ',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      content: const Text('最新のバージョンにアップデートしてください'),
      actions: [
        MyButton(
          buttonName: 'to_store_for_update_button',
          buttonType: ButtonType.main,
          onPressed: () => ref.read(appInfoServiceProvider).launchStore(),
          child: const Text('アップデートする'),
        ),
      ],
    );
  }
}
