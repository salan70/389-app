import 'package:flutter/material.dart';

import '../../../../util/constant/strings_constant.dart';

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
