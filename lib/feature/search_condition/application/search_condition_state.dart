import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/search_condition.dart';
import '../domain/search_condition_repository.dart';

// todo stateProvider
final searchConditionProvider = StateProvider.autoDispose<SearchCondition>(
  (ref) => ref.watch(searchConditionRepositoryProvider).fetchSearchCondition(),
);
