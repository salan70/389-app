import 'package:flutter/material.dart';

import 'retire_confirm_dialog.dart';

class RetireButtonWidget extends StatelessWidget {
  const RetireButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return const RetireConfirmDialog();
          },
        );
      },
      child: const Text('諦める'),
    );
  }
}
