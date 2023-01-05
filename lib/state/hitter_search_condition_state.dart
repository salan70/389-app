import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/typeadapter/hitter_search_condition.dart';
import '../repository/hitter_search_condition_repository.dart';

// TODO(me): 初期値をHiveで取得するようにする
final hitterSearchConditionProvider = StateProvider<HitterSearchCondition>(
  (ref) => ref
      .watch(hitterSearchConditionRepositoryProvider)
      .fetchHitterSearchCondition(),
);
