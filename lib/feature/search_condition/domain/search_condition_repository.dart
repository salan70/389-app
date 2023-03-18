import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'search_condition.dart';

final searchConditionRepositoryProvider = Provider<SearchConditionRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class SearchConditionRepository {
  SearchCondition fetchSearchCondition();

  void saveSearchCondition(SearchCondition searchCondition);
}
