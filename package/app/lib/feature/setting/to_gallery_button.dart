import 'package:flutter/material.dart';

import '../../../core/common_widget/button/my_button.dart';
import '../gallery/base_gallery_list_page.dart';

class ToGalleryButton extends StatelessWidget {
  const ToGalleryButton({super.key, required this.buttonType});

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'to_gallery_button',
      buttonType: buttonType,
      onPressed: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => const BaseGalleryListPage(),
            settings: const RouteSettings(
              name: '/base_gallery_list_page',
            ),
          ),
        );
      },
      child: Text(
        'プレイ履歴',
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
        ),
      ),
    );
  }
}
