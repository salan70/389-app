import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../daily_quiz/domain/daily_quiz.dart';
import '../../search_condition/domain/search_condition.dart';
import 'hitter.dart';
import 'hitter_quiz.dart';

part 'hitter_repository.g.dart';

@riverpod
HitterRepository hitterRepository(HitterRepositoryRef ref) =>
    throw UnimplementedError('Provider was not initialized');

abstract class HitterRepository {
  /// 検索条件に合う野手を1人取得し、[HitterQuiz] として返す。
  Future<HitterQuiz> fetchHitterQuizBySearchCondition(
    SearchCondition searchCondition,
  );

  /// IDで野手を1人取得し、[HitterQuiz] として返す。
  Future<HitterQuiz> fetchHitterQuizById(DailyQuiz dailyQuiz);

  /// 登録されている全ての野手を取得する。
  Future<List<Hitter>> fetchAllHitter();
}
