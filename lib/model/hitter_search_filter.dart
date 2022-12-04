import 'package:freezed_annotation/freezed_annotation.dart';

part 'hitter_search_filter.freezed.dart';

@freezed
class HitterSearchFilter with _$HitterSearchFilter {
  const factory HitterSearchFilter({
    required List<String> teamList,
    required int minGames,
    required int minHits,
    required int minPa, // pa: 打席数
  }) = _HitterSearchFilter;
}
