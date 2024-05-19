import 'package:flutter_test/flutter_test.dart';
import 'package:model/src/util/enum/hitting_stats_type.dart';

import '../../../dummy_data/dummy_hitter_quiz_result.dart';

void main() {
  // ベースとなるhitterQuiz（公開しうる成績の総数は20）
  // これをコピーして、isCorrectやincorrectCount,unveilCountを変更してテストを行う
  final baseHitterQuizResult = dummyHitterQuizResult.copyWith(
    isCorrect: true,
    hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
      incorrectCount: 0,
      unveilCount: 0,
    ),
  );

  // 四捨五入するケースのテストができてない懸念あり
  group('quiz.unveilPercentage', () {
    test('0', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult;

      // Act
      final result = hitterQuizResult.unveilPercentage;

      // Assert
      const expected = '0';
      expect(expected, result);
    });
    test('5', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 0,
          unveilCount: 1,
        ),
      );

      // Act
      final result = hitterQuizResult.unveilPercentage;

      // Assert
      const expected = '5';
      expect(expected, result);
    });

    test('100', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 0,
          unveilCount: 20,
        ),
      );

      // Act
      final result = hitterQuizResult.unveilPercentage;

      // Assert
      const expected = '100';
      expect(expected, result);
    });
  });

  group('quiz.totalStatsCount', () {
    test('20', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult;

      // Act
      final result = hitterQuizResult.totalStatsCount;

      // Assert
      const expected = 20;
      expect(expected, result);
    });
  });

  group('quiz.unveilRate', () {
    test('0(0/20)', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult;

      // Act
      final result = hitterQuizResult.unveilRate;

      // Assert
      const expected = 0;
      expect(expected, result);
    });

    test('0.35(7/20)', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          unveilCount: 7,
        ),
      );

      // Act
      final result = hitterQuizResult.unveilRate;

      // Assert
      const expected = 0.35;
      expect(expected, result);
    });

    test('1(20/20)', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          unveilCount: 20,
        ),
      );

      // Act
      final result = hitterQuizResult.unveilRate;

      // Assert
      const expected = 1;
      expect(expected, result);
    });
  });
  group('quiz.resultRank', () {
    test('incorrect', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: false,
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.incorrect;
      expect(expected, result);
    });
    test('ssランク_不正解0(境界値)_公開2/20(境界値)', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 0,
          unveilCount: 1,
        ),
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.ss;
      expect(expected, result);
    });

    test('sランク_不正解1(ssの境界値+1)_公開2/20', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 1,
          unveilCount: 2,
        ),
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.s;
      expect(expected, result);
    });

    test('sランク_不正解1_公開3/20(ssの境界値+1)', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 1,
          unveilCount: 3,
        ),
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.s;
      expect(expected, result);
    });

    test('sランク_不正解2(境界値)_公開4/20(境界値)', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 2,
          unveilCount: 4,
        ),
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.s;
      expect(expected, result);
    });

    test('aランク_不正解2_公開5/20(sの境界値+1)', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 2,
          unveilCount: 5,
        ),
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.a;
      expect(expected, result);
    });

    test('aランク_不正解3(sの境界値+1)_公開4/20', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 3,
          unveilCount: 4,
        ),
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.a;
      expect(expected, result);
    });

    test('aランク_不正解4(境界値)_公開10/20(境界値)', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 4,
          unveilCount: 10,
        ),
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.a;
      expect(expected, result);
    });

    test('bランク_不正解5(aの境界値+1)_公開10/20', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 5,
          unveilCount: 10,
        ),
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.b;
      expect(expected, result);
    });

    test('bランク_不正解4_公開11/20(aの境界値+1)', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 4,
          unveilCount: 11,
        ),
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.b;
      expect(expected, result);
    });

    test('bランク_不正解9(境界値)_公開14/20(境界値)', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 9,
          unveilCount: 14,
        ),
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.b;
      expect(expected, result);
    });

    test('cランク_不正解10(bの境界値+1)_公開14/20', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 10,
          unveilCount: 14,
        ),
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.c;
      expect(expected, result);
    });

    test('cランク_不正解9_公開15/20(bの境界値+1)', () {
      // Arrange
      final hitterQuizResult = baseHitterQuizResult.copyWith(
        isCorrect: true,
        hitterQuiz: dummyHitterQuizResult.hitterQuiz.copyWith(
          incorrectCount: 9,
          unveilCount: 15,
        ),
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.c;
      expect(expected, result);
    });
  });
}
