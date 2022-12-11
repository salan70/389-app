import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'component/input_answer_view.dart';
import 'component/quiz_event_buttons_view.dart';
import 'component/quiz_view.dart';

class PlayQuizPage extends ConsumerWidget {
  const PlayQuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('プレイ'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              QuizView(),
              QuizEventButtons(),
              InputAnswer(),
            ],
          ),
        ),
      ),
    );
  }
}
