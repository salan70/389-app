import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz_setting_page_controller.g.dart';

@riverpod
QuizSettingPageController quizSettingPageController(
  QuizSettingPageControllerRef ref,
) =>
    QuizSettingPageController(ref);

class QuizSettingPageController {
  QuizSettingPageController(this._ref);

  final Ref _ref;
}
