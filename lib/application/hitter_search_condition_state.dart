import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/typeadapter/hitter_search_condition.dart';
import '../repository/hitter_search_condition_repository.dart';

final hitterSearchConditionProvider = StateProvider<HitterSearchCondition>(
  (ref) => ref
      .watch(hitterSearchConditionRepositoryProvider)
      .fetchHitterSearchCondition(),
);
