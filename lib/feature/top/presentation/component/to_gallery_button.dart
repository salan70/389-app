import 'package:flutter/material.dart';

import '../../../quiz_result/presentation/gallery_list/base_gallery_list_page.dart';

class ToGalleryButton extends StatelessWidget {
  const ToGalleryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => const BaseGalleryListPage(),
          ),
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
