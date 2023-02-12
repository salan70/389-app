import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/hitter_search_condition.dart';
import '../../domain/repository/hitter_search_condition_repository.dart';

final hitterSearchConditionProvider = StateProvider<HitterSearchCondition>(
  (ref) => ref
      .watch(hitterSearchConditionRepositoryProvider)
      .fetchHitterSearchCondition(),
);
