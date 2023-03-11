import 'package:flutter/material.dart';

import '../../gallery/base_gallery_page.dart';

class ToGalleryButton extends StatelessWidget {
  const ToGalleryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute(builder: (context) => const BaseGalleryPage()),
        );
      },
      icon: const Icon(
        Icons.info_outline_rounded,
      ),
      label: Text(
        'ギャラリー',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
