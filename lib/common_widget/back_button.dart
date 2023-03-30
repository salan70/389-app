import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: Navigator.of(context).pop,
      child: const Text('戻る'),
    );
  }
}
