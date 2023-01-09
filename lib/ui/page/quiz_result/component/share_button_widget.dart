import 'package:flutter/material.dart';

class ShareButtonWidget extends StatelessWidget {
  const ShareButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          // TODO(me): シェア機能実装する
        },
        child: const Text('クイズをシェア！'),
      ),
    );
  }
}
