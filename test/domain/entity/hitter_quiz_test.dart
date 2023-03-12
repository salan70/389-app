import 'package:baseball_quiz_app/util/constant/hitting_stats_constant.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_hitter_quiz_result.dart';

void main() {
  // ベースとなるhitterQuiz（公開しうる成績の総数は20）
  // これをコピーして、isCorrectやincorrectCount,unveilCountを変更してテストを行う
  final baseHitterQuizResult = dummyHitterQuizResult.copyWith(
    isCorrect: true,
    incorrectCount: 0,
    unveilCount: 0,
    yearList: ['2019', '2020', '2021', '2022', 'NPB：4年'],
    selectedStatsList: ['球団', '打率', '本塁打', 'OPS'],
  );

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
        unveilCount: 7,
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
        unveilCount: 20,
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
        incorrectCount: 0,
        unveilCount: 1,
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
        incorrectCount: 1,
        unveilCount: 2,
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
        incorrectCount: 1,
        unveilCount: 3,
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
        incorrectCount: 2,
        unveilCount: 4,
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
        incorrectCount: 2,
        unveilCount: 5,
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
        incorrectCount: 3,
        unveilCount: 4,
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
        incorrectCount: 4,
        unveilCount: 10,
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
        incorrectCount: 5,
        unveilCount: 10,
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
        incorrectCount: 4,
        unveilCount: 11,
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
        incorrectCount: 9,
        unveilCount: 14,
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
        incorrectCount: 10,
        unveilCount: 14,
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
        incorrectCount: 9,
        unveilCount: 15,
      );

      // Act
      final result = hitterQuizResult.resultRank;

      // Assert
      const expected = ResultRank.c;
      expect(expected, result);
    });
  });
}
