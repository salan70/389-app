import 'package:flutter/material.dart';

class NotesText extends StatelessWidget {
  const NotesText({super.key});

  @override
  Widget build(BuildContext context) {
    const quizNotes = '※成績等は2022年12月4日に取得したものを使用しています。';

    return const Text(
      quizNotes,
      textAlign: TextAlign.center,
    );
  }
}
