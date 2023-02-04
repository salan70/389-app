import 'package:baseball_quiz_app/state/hitter_quiz_ui_state.dart';
import 'package:baseball_quiz_app/ui/page/play_quiz/play_quiz_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_hitter.dart';

void main() {
  group('isCorrectHitterQuiz関数', () {
    test('正解している', () {
      final container = ProviderContainer(
        overrides: [
          hitterQuizUiStateProvider.overrideWith(
            (ref) => const AsyncData(dummyHitterQuizUi),
          ),
          selectedHitterIdProvider.overrideWith(
            (ref) => '9d377b08-3b1d-4ff2-892f-597c404e4b7d',
          ),
        ],
      );
      final result =
          container.read(playQuizViewModelProvider).isCorrectHitterQuiz();
      expect(true, result);
    });

    test('不正解している', () {
      final container = ProviderContainer(
        overrides: [
          hitterQuizUiStateProvider.overrideWith(
            (ref) => const AsyncData(dummyHitterQuizUi),
          ),
          selectedHitterIdProvider.overrideWith(
            (ref) => 'incorrect Id',
          ),
        ],
      );
      final result =
          container.read(playQuizViewModelProvider).isCorrectHitterQuiz();
      expect(false, result);
    });
  });

  group('isShownAds関数', () {
    test('bool型を返すか確認', () {
      final result =
          ProviderContainer().read(playQuizViewModelProvider).isShownAds();
      expect(bool, result.runtimeType);
    });
  });
}
