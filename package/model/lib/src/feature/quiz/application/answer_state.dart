import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../season/util/season_type.dart';
import '../domain/hitter.dart';
import '../infrastructure/hitter_repository.dart';

part 'answer_state.g.dart';

/// 全野手のIDと名前のリストを返すプロバイダー
@riverpod
Future<List<Hitter>> allHitterList(
  AllHitterListRef ref,
  SeasonType seasonType,
) async =>
    ref.watch(hitterRepositoryProvider).fetchAllHitter(seasonType);
