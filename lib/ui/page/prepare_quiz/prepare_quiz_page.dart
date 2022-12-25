import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../play_quiz/play_quiz_page.dart';
import 'component/chose_team_widget.dart';

class PrepareQuizPage extends ConsumerWidget {
  const PrepareQuizPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('プレイ'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const ChoseTeamWidget(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => const PlayQuizPage(),
                    ),
                  );
                },
                child: const Text('クイズへ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
