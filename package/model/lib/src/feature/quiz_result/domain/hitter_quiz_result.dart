import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../util/enum/hitting_stats_type.dart';
import '../../quiz/domain/hitter_quiz.dart';

part 'hitter_quiz_result.freezed.dart';

@freezed
class HitterQuizResult with _$HitterQuizResult {
  const factory HitterQuizResult({
    required String docId,
    required DateTime updatedAt,
    required bool isCorrect,
    required HitterQuiz hitterQuiz,
  }) = _HitterQuizResult;

  const HitterQuizResult._();

  // TODO(me): selectedStatsListに年度が含まれた場合、年度をremoveする処理を書く'

  /// 表示しうる成績の数
  int get totalStatsCount =>
      hitterQuiz.statsMapList.length *
      hitterQuiz.statsMapList.first.keys.length;

  /// 成績を表示した割合
  double get unveilRate => hitterQuiz.unveilCount / totalStatsCount;

  /// 間違えた数と表示した割合から評価を行う
  ResultRank get resultRank {
    // * 不正解の場合
    if (!isCorrect) {
      return ResultRank.incorrect;
    }

    // * 正解の場合
    final incorrectCount = hitterQuiz.incorrectCount;
    if (incorrectCount == 0 && unveilRate <= 0.1) {
      return ResultRank.ss;
    }

    if (incorrectCount <= 2 && unveilRate <= 0.2) {
      return ResultRank.s;
    }

    if (incorrectCount <= 4 && unveilRate <= 0.5) {
      return ResultRank.a;
    }

    if (incorrectCount <= 9 && unveilRate <= 0.7) {
      return ResultRank.b;
    }

    return ResultRank.c;
  }

  // 一旦ここにこのロジック書いているが、他で同じような関数を使う可能性あり
  // その場合は別の場所に移動する
  /// 表示した割合を整数第1位で四捨五入し文字列で返す
  String get unveilPercentage => (unveilRate * 100).toStringAsFixed(0);
}
