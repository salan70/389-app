import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:model/src/feature/quiz/application/answer_state.dart';
import 'package:model/src/feature/quiz/application/hitter_quiz_service.dart';
import 'package:model/src/feature/quiz/domain/hitter.dart';

void main() {
  group('filterHitter関数', () {
    final hitterList = [
      const Hitter(label: '坂本勇人（捕手）', id: '1'),
      const Hitter(label: '坂本勇人（内野手）', id: '2'),
      const Hitter(label: 'レオネス・マーティン', id: '3'),
      const Hitter(label: 'T-岡田', id: '4'),
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
          .read(hitterQuizServiceProvider)
          .searchHitter(searchWord);

      final expected = [
        const Hitter(label: 'レオネス・マーティン', id: '3'),
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
          .read(hitterQuizServiceProvider)
          .searchHitter(searchWord);

      final expected = [
        const Hitter(label: '坂本勇人（捕手）', id: '1'),
        const Hitter(label: '坂本勇人（内野手）', id: '2'),
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
          .read(hitterQuizServiceProvider)
          .searchHitter(searchWord);

      final expected = [
        const Hitter(label: 'T-岡田', id: '4'),
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
          .read(hitterQuizServiceProvider)
          .searchHitter(searchWord);

      final expected = <Hitter>[];

      expect(expected, result);
    });
  });

  // group('isCorrectHitterQuiz関数', () {
  //   test('正解している', () {
  //     final container = ProviderContainer(
  //       overrides: [
  //         hitterQuizStateProvider.overrideWith(
  //           (ref) => const AsyncData(dummyHitterQuiz),
  //         ),
  //         submittedHitterProvider.overrideWith(
  //           (ref) => const Hitter(
  //             label: '牧秀悟',
  //             id: '9d377b08-3b1d-4ff2-892f-597c404e4b7d',
  //           ),
  //         ),
  //       ],
  //     );
  //     final result =
  //         container.read(hitterQuizServiceProvider).isCorrectHitterQuiz();
  //     expect(true, result);
  //   });

  //   test('不正解している', () {
  //     final container = ProviderContainer(
  //       overrides: [
  //         hitterQuizStateProvider.overrideWith(
  //           (ref) => const AsyncData(dummyHitterQuiz),
  //         ),
  //         submittedHitterProvider.overrideWith(
  //           (ref) => const Hitter(label: '牧秀悟', id: 'incorrect Id'),
  //         ),
  //       ],
  //     );
  //     final result =
  //         container.read(hitterQuizServiceProvider).isCorrectHitterQuiz();
  //     expect(false, result);
  //   });

  //   test('null', () {
  //     final container = ProviderContainer(
  //       overrides: [
  //         hitterQuizStateProvider.overrideWith(
  //           (ref) => const AsyncData(dummyHitterQuiz),
  //         ),
  //         submittedHitterProvider.overrideWith(
  //           (ref) => null,
  //         ),
  //       ],
  //     );
  //     final result =
  //         container.read(hitterQuizServiceProvider).isCorrectHitterQuiz();
  //     expect(false, result);
  //   });
  // });
}
