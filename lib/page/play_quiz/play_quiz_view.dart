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
          OpenStatsButton(),
        ],
      ),
    );
  }
}

class OpenStatsButton extends ConsumerWidget {
  const OpenStatsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(playQuizViewModelProvider);
    return TextButton(
      onPressed: () {
        // TODO 成績を開ける
        viewModel.addId();
      },
      child: const Text('次の成績を表示'),
    );
  }
}
