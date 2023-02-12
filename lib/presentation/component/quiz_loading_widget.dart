import 'package:flutter/material.dart';

/// HitterQuizのローディング時に表示
/// 二度押しを防止したいときなどに使用するオーバーレイローディング
class QuizLoadingWidget extends StatelessWidget {
  const QuizLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.black26,
      child: Center(
        child: LoadingDialog(),
      ),
    );
  }
}

/// ローディング中であることを知らせるダイアログ
class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            // The loading indicator
            CircularProgressIndicator(),
            SizedBox(
              height: 24,
            ),
            // Some text
            Text('Loading...')
          ],
        ),
      ),
    );
  }
}
