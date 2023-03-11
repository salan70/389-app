import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../page/top/top_page.dart';

class ToTopButton extends ConsumerWidget {
  const ToTopButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => const TopPage(),
          ),
        );
      },
      child: const Text('TOPへ戻る'),
    );
  }
}
