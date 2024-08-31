import 'package:flutter/material.dart';

import '../../core/util/extension/context_extension.dart';
import '../component/common/button/my_button.dart';

/// 広告を非表示にするためのリワード広告再生ダイアログ。
///
/// 周りを半透明にすることでダイアログを模している。
/// 処理や状態管理が複雑で、 `controller` を持ちたいために `XXPage` という命名にしている。
class HideAdDialogPage extends StatelessWidget {
  const HideAdDialogPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '動画広告1回視聴で1時間広告なし！\n'
            '2回視聴 +「今日の1問」プレイで次の19時まで広告なし！',
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _AdStatusIcon(
                isChecked: true,
                color: Colors.blue,
              ),
              SizedBox(width: 16),
              _AdStatusIcon(
                isChecked: false,
                color: Colors.blue,
              ),
              SizedBox(width: 16),
              _AdStatusIcon(
                isChecked: false,
                color: Colors.orange,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text('2024/08/28 15:02まで広告なし！'),
        ],
      ),
      actionsPadding: const EdgeInsets.only(bottom: 8, right: 24),
      actions: <Widget>[
        MyButton(
          buttonName: 'confirm_no_button',
          buttonType: ButtonType.sub,
          onPressed: context.pop,
          child: const Text('閉じる'),
        ),
        MyButton(
          buttonName: 'confirm_yes_button',
          buttonType: ButtonType.alert,
          onPressed: () {
            context.pop();
          },
          child: const Text('広告を見る'),
        ),
      ],
    );
  }
}

class _AdStatusIcon extends StatelessWidget {
  const _AdStatusIcon({
    required this.isChecked,
    required this.color,
  });

  final bool isChecked;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isChecked
          ? Icons.check_box_rounded
          : Icons.check_box_outline_blank_rounded,
      size: 64,
      color: isChecked ? color : color.withOpacity(0.2),
    );
  }
}
