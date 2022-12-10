import 'package:baseball_quiz_app/page/play_quiz/play_quiz_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'component/quiz_view.dart';

class PlayQuizView extends ConsumerWidget {
  const PlayQuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プレイ'),
      ),
      body: Column(
        children: const [
          QuizView(),
          QuizEventButtons(),
        ],
      ),
    );
  }
}

class QuizEventButtons extends ConsumerWidget {
  const QuizEventButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(playQuizViewModelProvider);
    return Row(
      children: [
        TextButton(
          onPressed: () {
            if (viewModel.canAddId()) {
              viewModel.addId();
            } else {
              // TODO Buttonを非活性にする
            }
          },
          child: const Text('次の成績を表示'),
        ),
        TextButton(
          onPressed: () {
            // TODO 本当に良いか確認するダイアログ表示させる
            if (viewModel.canAddId()) {
              viewModel.addAllId();
            } else {
              // TODO Buttonを非活性にする
            }
          },
          child: const Text('全ての成績を表示'),
        ),
      ],
    );
  }
}
