import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import '../button/my_button.dart';

class ToGalleryButton extends StatelessWidget {
  const ToGalleryButton({super.key, required this.buttonType});

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'to_gallery_button',
      buttonType: buttonType,
      onPressed: () => context.pushRoute(const GalleryListRoute()),
      child: Text(
        'プレイ履歴',
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
        ),
      ),
    );
  }
}
