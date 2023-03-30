import 'package:flutter/material.dart';

class BackToTopButton extends StatelessWidget {
  const BackToTopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: const Text('TOPへ戻る'),
    );
  }
}
