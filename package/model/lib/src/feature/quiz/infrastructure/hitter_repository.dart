import 'dart:math';

import 'package:common/common.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../daily_quiz/domain/daily_quiz.dart';
import '../../search_condition/domain/search_condition.dart';
import '../../season/util/season_type.dart';
import '../domain/hitter.dart';
import '../domain/hitter_quiz_state.dart';
import 'entity/hitting_stats.dart';
import 'entity/supabase_hitter.dart';
import 'hitter_converter.dart';

part 'hitter_repository.g.dart';

@riverpod
HitterRepository hitterRepository(HitterRepositoryRef ref) {
  return HitterRepository(Supabase.instance);
}

class HitterRepository {
  HitterRepository(this.supabase);

  final Supabase supabase;

  /// ノーマルクイズ用の選手情報を取得する。
  ///
  /// 検索条件に合う選手を1人取得し、その選手の成績を取得して返す。
  Future<HitterQuizState> fetchNormalHitterQuizState(
    SearchCondition searchCondition,
    SeasonType seasonType,
  ) async {
    // 検索条件に合う選手を1人取得する。
    final supabaseHitter =
        await _searchHitterBySearchCondition(searchCondition, seasonType);

    // 取得した選手の成績を取得する。
    final statsList = await _fetchHittingStats(supabaseHitter.id, seasonType);

    // InputNormalQuizState に変換して返す。
    return HitterConverter().toInputNormalQuizState(
      supabaseHitter,
      statsList,
      searchCondition.selectedStatsList,
      seasonType,
    );
  }

  /// デイリークイズ用の選手情報を取得する。
  ///
  /// 指定されたデイリークイズの選手 ID から選手情報を取得し、その選手の成績を取得して返す。
  Future<HitterQuizState> fetchInputDailyQuizState(DailyQuiz dailyQuiz) async {
    final seasonType = dailyQuiz.seasonType;

    // 検索条件に合う選手を1人取得する。
    final supabaseHitter =
        await _searchHitterById(dailyQuiz.playerId, seasonType);

    // 取得した選手の成績を取得する。
    final statsList = await _fetchHittingStats(supabaseHitter.id, seasonType);

    // InputDailyQuizState に変換して返す。
    return HitterConverter().toInputDailyQuizState(
      supabaseHitter,
      statsList,
      dailyQuiz.selectedStatsList,
      seasonType,
    );
  }

  /// 検索条件で選手で検索し、ランダムで1人返す。
  Future<SupabaseHitter> _searchHitterBySearchCondition(
    SearchCondition searchCondition,
    SeasonType seasonType,
  ) async {
    final hittingStatsTable = seasonType.hittingStatsTable;
    final responses = await supabase.client
        .from(seasonType.hitterTable)
        .select<dynamic>('id, name, team, hasData, $hittingStatsTable!inner(*)')
        .eq('hasData', true)
        .filter('team', 'in', searchCondition.teamList)
        .gte('$hittingStatsTable.試合', searchCondition.minGames)
        .gte('$hittingStatsTable.安打', searchCondition.minHits)
        .gte('$hittingStatsTable.本塁打', searchCondition.minHr)
        // ? なぜか `ascending` は true でも false でも同じ結果になる。
        // ? UI での挙動的には問題ないので、このままにしておいている。
        .order('表示順', foreignTable: hittingStatsTable) as List<dynamic>;

    // 検索条件に合致する選手がいない場合、例外を返す。
    if (responses.isEmpty) {
      throw SupabaseException.notFound();
    }

    // ランダムで1人選出する。
    final chosenResponse =
        responses[Random().nextInt(responses.length)] as Map<String, dynamic>;

    return SupabaseHitter.fromJson(chosenResponse);
  }

  /// ID で選手を検索する。
  Future<SupabaseHitter> _searchHitterById(
    String id,
    SeasonType seasonType,
  ) async {
    final responses = await supabase.client
        .from(seasonType.hitterTable)
        .select<dynamic>(
          'id, name, team, hasData',
        )
        .eq('hasData', true)
        .eq('id', id) as List<dynamic>;

    // 検索条件に合致する選手がいない場合、例外を返す
    if (responses.isEmpty) {
      throw SupabaseException.notFound();
    }

    return SupabaseHitter.fromJson(responses[0] as Map<String, dynamic>);
  }

  /// [playerId] から打撃成績の List を取得するする。
  Future<List<HittingStats>> _fetchHittingStats(
    String playerId,
    SeasonType seasonType,
  ) async {
    final statsList = <HittingStats>[];
    final responses = await supabase.client
        .from(seasonType.hittingStatsTable)
        .select<dynamic>()
        .eq('playerId', playerId) as List<dynamic>;

    for (final response in responses) {
      final stats = HittingStats.fromJson(response as Map<String, dynamic>);
      statsList.add(stats);
    }

    return statsList;
  }

  /// 解答を入力するテキストフィールドの検索用。
  ///
  /// 全選手の名前と ID を取得する。
  Future<List<Hitter>> fetchAllHitter(SeasonType seasonType) async {
    final responses = await supabase.client
        .from(seasonType.hitterTable)
        .select<dynamic>() as List<dynamic>;

    final allHitterList = <Hitter>[];
    for (final response in responses) {
      final hitterMap = Hitter.fromJson(
        response as Map<String, dynamic>,
      );
      allHitterList.add(hitterMap);
    }
    return allHitterList;
  }
}
