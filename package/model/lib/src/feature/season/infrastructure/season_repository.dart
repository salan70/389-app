import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../util/season_type.dart';

part 'season_repository.g.dart';

@riverpod
SeasonRepository seasonRepository(SeasonRepositoryRef ref) =>
    SeasonRepository();

class SeasonRepository {
  /// [baseDate]を基準として、対象となるシーズンを取得する。
  Future<SeasonType> fetchTargetSeason(DateTime baseDate) async {
    // todo: 実装する。
    return SeasonType.end2022;
  }
}
