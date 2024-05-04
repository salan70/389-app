import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../util/enum/quiz_type.dart';
import '../../quiz_result/domain/hitter_quiz_result.dart';
import 'hitter.dart';
import 'stats_value.dart';

part 'hitter_quiz_state.freezed.dart';

/// 回答状況や対象の選手など、クイズの状態を表現する。
@freezed
class HitterQuizState with _$HitterQuizState {
  const factory HitterQuizState({
    /// 回答となる [Hitter] の id.
    required String id,

    /// 回答となる [Hitter] の名前。
    required String name,

    /// ユーザーが回答として入力した [Hitter].
    required Hitter? enteredHitter,

    /// クイズの種別。
    required QuizType? quizType,

    /// クイズの対象となる年度のリスト。
    required List<String> yearList,

    /// クイズの対象となる成績の種類リスト。
    /// 
    /// 例: ['打率', '本塁打', '打点', '盗塁']
    required List<String> selectedStatsList,

    /// クイズの対象となる成績の値のリスト。
    required List<Map<String, StatsValue>> statsMapList,

    /// 公開された成績の数。
    required int unveilCount,

    /// 正解したかどうか。
    required bool isCorrect,

    /// 不正解した回数。
    required int incorrectCount,
  }) = _HitterQuizState;
  const HitterQuizState._();

  factory HitterQuizState.fromHitterResult(
    HitterQuizResult result,
    QuizType quizType,
  ) {
    return HitterQuizState(
      id: result.id,
      name: result.name,
      enteredHitter: null,
      quizType: quizType,
      yearList: result.yearList,
      selectedStatsList: result.selectedStatsList,
      statsMapList: result.statsMapList,
      unveilCount: result.unveilCount,
      isCorrect: result.isCorrect,
      incorrectCount: result.incorrectCount,
    );
  }

  /// 入力中の野手（ [enteredHitter] ）が正解かどうか。
  bool get isCorrectHitterQuiz => enteredHitter?.id == id;

  /// すべての成績数。
  int get totalStatsCount => statsMapList.length * selectedStatsList.length;

  /// すべての成績が公開されているかどうか。
  bool get isAllStatsUnveiled => unveilCount >= totalStatsCount;
}
