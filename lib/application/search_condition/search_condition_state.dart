import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/search_condition.dart';
import '../../domain/repository/search_condition_repository.dart';

final searchConditionProvider = StateProvider<SearchCondition>(
  (ref) => ref.watch(searchConditionRepositoryProvider).fetchSearchCondition(),
);
