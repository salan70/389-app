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
        children: const [QuizView()],
      ),
    );
  }
}
