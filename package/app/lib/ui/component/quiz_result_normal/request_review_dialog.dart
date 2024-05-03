import 'package:flutter/material.dart';

import '../../../core/util/extension/context_extension.dart';
import '../common/button/my_button.dart';

class RequestReviewDialog extends StatelessWidget {
  const RequestReviewDialog({super.key, required this.onAcceptReview});

  /// レビューすることを承認した際の処理。
  final VoidCallback onAcceptReview;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'レビューをお願いします！',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      content: const Text('''.389をお楽しみいただきありがとうございます！
    \n少しでも.389を気に入っていただけましたら、5秒で終わりますので、是非星5のレビューをお願いします。
    \nレビューをいただけると、開発者のモチベーションが上がり、はしゃぎます。
    \nより一層楽しいアプリへの改善に繋がりますので、ご協力をお願いします！
    '''),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.only(right: 20, bottom: 8, left: 20),
      actions: [
        MyButton(
          buttonName: 'cancel_button_in_request_review_dialog',
          buttonType: ButtonType.sub,
          onPressed: context.pop,
          child: const Text('今はやめとく'),
        ),
        MyButton(
          buttonName: 'ok_button_in_request_review_dialog',
          buttonType: ButtonType.main,
          onPressed: onAcceptReview,
          child: const Text('レビューする！'),
        ),
      ],
    );
  }
}
