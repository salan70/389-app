import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_normal_quiz_page_controller.g.dart';

@riverpod
PlayNormalQuizPageController playNormalQuizPageController(
  PlayNormalQuizPageControllerRef ref,
) =>
    PlayNormalQuizPageController(ref);

class PlayNormalQuizPageController {
  PlayNormalQuizPageController(this._ref);

  final Ref _ref;
}
