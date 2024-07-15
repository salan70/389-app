import 'package:flutter/material.dart';

class NotesText extends StatelessWidget {
  const NotesText({super.key});

  @override
  Widget build(BuildContext context) {
    const quizNotes = '※成績等は2024年7月1日時点のものです';

    return const Text(
      quizNotes,
      textAlign: TextAlign.center,
    );
  }
}
