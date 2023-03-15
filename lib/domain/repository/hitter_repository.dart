import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../feature/search_condition/domain/search_condition.dart';
import '../entity/daily_quiz.dart';
import '../entity/hitter.dart';
import '../entity/hitter_quiz.dart';

final hitterRepositoryProvider = Provider<HitterRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class HitterRepository {
  /// 検索条件に合う野手を1人取得し、HitterQuiz型で返す
  Future<HitterQuiz> fetchHitterQuizBySearchCondition(
    SearchCondition searchCondition,
  );

  /// IDで野手を1人取得し、HitterQuiz型で返す
  Future<HitterQuiz> fetchHitterQuizById(
    DailyQuiz dailyQuiz,
  );

  /// 登録されている全ての野手を取得する
  Future<List<Hitter>> fetchAllHitter();
}
