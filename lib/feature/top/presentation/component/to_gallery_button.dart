import 'package:flutter/material.dart';

import '../../../../common_widget/my_button.dart';
import '../../../quiz_result/presentation/gallery_list/base_gallery_list_page.dart';

class ToGalleryButton extends StatelessWidget {
  const ToGalleryButton({super.key, required this.isMain});

  final bool isMain;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      isMain: isMain,
      onPressed: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => const BaseGalleryListPage(),
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
