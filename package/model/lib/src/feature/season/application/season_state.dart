import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../infrastructure/season_repository.dart';
import '../util/season_type.dart';

part 'season_state.g.dart';

@riverpod
Future<SeasonType> targetSeason(TargetSeasonRef ref, DateTime baseDate) async {
  return ref.watch(seasonRepositoryProvider).fetchTargetSeason(baseDate);
}
