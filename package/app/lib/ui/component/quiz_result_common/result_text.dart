import 'package:flutter/material.dart';
import 'package:model/model.dart';

class ResultText extends StatelessWidget {
  const ResultText({super.key, required this.hitterQuiz});

  final HitterQuizState hitterQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 64,
        child: hitterQuiz.isCorrect
            ? const Text('正解！')
            : Column(
                children: [
                  const Text('残念...'),
                  Text('正解は、${hitterQuiz.name}選手でした。'),
                ],
              ),
      ),
    );
  }
}
