import 'package:baseball_quiz_app/application/hitter_quiz_ui_state.dart';
import 'package:baseball_quiz_app/domain/ui/hitter_id_by_name.dart';
import 'package:baseball_quiz_app/presentation/page/play_quiz/play_quiz_view_model.dart';
import 'package:baseball_quiz_app/repository/supabase/supabase_hitter_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_hitter.dart';

void main() {
  group('filterHitter関数', () {
    final hitterList = [
      const HitterIdByName(label: '坂本勇人（捕手）', id: '1'),
      const HitterIdByName(label: '坂本勇人（内野手）', id: '2'),
      const HitterIdByName(label: 'レオネス・マーティン', id: '3'),
      const HitterIdByName(label: 'T-岡田', id: '4'),
    ];

    test('5文字（カタカナ）, 1選手に該当', () async {
      final container = ProviderContainer(
        overrides: [
          allHitterListProvider.overrideWith(
            (ref) => Future.value(hitterList),
          ),
        ],
      );
      const searchWord = 'マーティン';
      final result = await container
          .read(playQuizViewModelProvider)
          .filterHitter(searchWord);

      final expected = [
        const HitterIdByName(label: 'レオネス・マーティン', id: '3'),
      ];

      expect(expected, result);
    });

    test('2文字（漢字）, 2選手に該当', () async {
      final container = ProviderContainer(
        overrides: [
          allHitterListProvider.overrideWith(
            (ref) => Future.value(hitterList),
          ),
        ],
      );
      const searchWord = '坂本';
      final result = await container
          .read(playQuizViewModelProvider)
          .filterHitter(searchWord);

      final expected = [
        const HitterIdByName(label: '坂本勇人（捕手）', id: '1'),
        const HitterIdByName(label: '坂本勇人（内野手）', id: '2'),
      ];

      expect(expected, result);
    });

    test('1文字（アルファベット）, 1選手に該当', () async {
      final container = ProviderContainer(
        overrides: [
          allHitterListProvider.overrideWith(
            (ref) => Future.value(hitterList),
          ),
        ],
      );
      const searchWord = 'T';
      final result = await container
          .read(playQuizViewModelProvider)
          .filterHitter(searchWord);

      final expected = [
        const HitterIdByName(label: 'T-岡田', id: '4'),
      ];

      expect(expected, result);
    });

    test('1文字（漢字）, 該当選手なし', () async {
      final container = ProviderContainer(
        overrides: [
          allHitterListProvider.overrideWith(
            (ref) => Future.value(hitterList),
          ),
        ],
      );
      const searchWord = '神';
      final result = await container
          .read(playQuizViewModelProvider)
          .filterHitter(searchWord);

      final expected = <HitterIdByName>[];

      expect(expected, result);
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
