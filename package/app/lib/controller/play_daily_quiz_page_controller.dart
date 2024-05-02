import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_daily_quiz_page_controller.g.dart';

@riverpod
PlayDailyQuizPageController playDailyQuizPageController(
  PlayDailyQuizPageControllerRef ref,
) =>
    PlayDailyQuizPageController(ref);

class PlayDailyQuizPageController {
  PlayDailyQuizPageController(this._ref);

  final Ref _ref;
}
