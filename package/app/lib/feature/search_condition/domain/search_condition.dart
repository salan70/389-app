import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'search_condition.freezed.dart';
part 'search_condition.g.dart';

@HiveType(typeId: 1)
@freezed
class SearchCondition with _$SearchCondition {
  const factory SearchCondition({
    @HiveField(0) required List<String> teamList,
    @HiveField(1) required int minGames,
    @HiveField(3) required int minHits,
    @HiveField(4) required int minHr,
    @HiveField(5) required List<String> selectedStatsList,
  }) = _SearchCondition;

  factory SearchCondition.fromJson(Map<String, dynamic> json) =>
      _$SearchConditionFromJson(json);

  @override
  Map<String, dynamic> toJson();
}
