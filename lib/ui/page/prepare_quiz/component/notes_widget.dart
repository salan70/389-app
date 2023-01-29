import 'package:flutter/material.dart';

import '../../../../constant/text_in_app.dart';

class NotesWidget extends StatelessWidget {
  const NotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      quizNotes,
      textAlign: TextAlign.center,
    );
  }
}
