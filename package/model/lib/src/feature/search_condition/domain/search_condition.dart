import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'search_condition.g.dart';

// Hive との兼ね合いの都合で freezed を使っていないが、本当は使いたい。
@immutable
@HiveType(typeId: 1)
class SearchCondition {
  const SearchCondition({
    required this.teamList,
    required this.minGames,
    required this.minHits,
    required this.minHr,
    required this.selectedStatsList,
  });

  factory SearchCondition.fromJson(Map<String, dynamic> json) {
    return SearchCondition(
      teamList: List<String>.from(json['teamList'] as List),
      minGames: json['minGames'] as int,
      minHits: json['minHits'] as int,
      minHr: json['minHr'] as int,
      selectedStatsList: List<String>.from(json['selectedStatsList'] as List),
    );
  }

  @HiveField(0)
  final List<String> teamList;
  @HiveField(1)
  final int minGames;
  @HiveField(3)
  final int minHits;
  @HiveField(4)
  final int minHr;
  @HiveField(5)
  final List<String> selectedStatsList;

  Map<String, dynamic> toJson() {
    return {
      'teamList': teamList,
      'minGames': minGames,
      'minHits': minHits,
      'minHr': minHr,
      'selectedStatsList': selectedStatsList,
    };
  }

  SearchCondition copyWith({
    List<String>? teamList,
    int? minGames,
    int? minHits,
    int? minHr,
    List<String>? selectedStatsList,
  }) {
    return SearchCondition(
      teamList: teamList ?? this.teamList,
      minGames: minGames ?? this.minGames,
      minHits: minHits ?? this.minHits,
      minHr: minHr ?? this.minHr,
      selectedStatsList: selectedStatsList ?? this.selectedStatsList,
    );
  }
}
