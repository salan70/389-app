import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/search_condition.dart';
import '../domain/search_condition_repository.dart';

final searchConditionProvider = StateProvider<SearchCondition>(
  (ref) => ref.watch(searchConditionRepositoryProvider).fetchSearchCondition(),
);
