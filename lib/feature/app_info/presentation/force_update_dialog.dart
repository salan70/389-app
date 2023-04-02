import 'package:baseball_quiz_app/common_widget/my_button.dart';
import 'package:baseball_quiz_app/feature/app_info/application/app_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../util/constant/button_type_constant.dart';

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
          buttonType: ButtonType.main,
          onPressed: () => ref.read(appInfoServiceProvider).launchStore(),
          child: const Text('アップデートする'),
        ),
      ],
    );
  }
}
