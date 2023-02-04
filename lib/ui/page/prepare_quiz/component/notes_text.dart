import 'package:flutter/material.dart';

import '../../../../util/constant/text_in_app.dart';

class NotesText extends StatelessWidget {
  const NotesText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      quizNotes,
      textAlign: TextAlign.center,
    );
  }
}
