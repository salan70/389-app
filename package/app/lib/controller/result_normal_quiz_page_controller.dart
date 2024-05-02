import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'result_normal_quiz_page_controller.g.dart';

@riverpod
ResultNormalQuizPageController resultNormalQuizPageController(
  ResultNormalQuizPageControllerRef ref,
) =>
    ResultNormalQuizPageController(ref);

class ResultNormalQuizPageController {
  ResultNormalQuizPageController(this._ref);

  final Ref _ref;
}
