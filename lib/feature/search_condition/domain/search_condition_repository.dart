import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'search_condition.dart';

part 'search_condition_repository.g.dart';

@riverpod
SearchConditionRepository searchConditionRepository(
  SearchConditionRepositoryRef ref,
) =>
    throw UnimplementedError('Provider was not initialized');

abstract class SearchConditionRepository {
  SearchCondition fetchSearchCondition();

  void saveSearchCondition(SearchCondition searchCondition);
}
