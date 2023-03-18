import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/browser_service.dart';
import '../util/browser_constant.dart';

class ToTermButton extends ConsumerWidget {
  const ToTermButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      onPressed: () {
        ref.read(browserServiceProvider).launchBrowser(termsUrl);
      },
      icon: const Icon(Icons.description_rounded),
      label: const Text('利用規約'),
    );
  }
}
