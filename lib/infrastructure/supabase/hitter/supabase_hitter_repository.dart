import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/entity/hitter_id_by_name.dart';
import '../../../domain/entity/hitter_quiz_ui.dart';
import '../../../domain/entity/hitter_search_condition.dart';
import '../../../domain/repository/hitter_repository.dart';
import '../../../util/exception/supabase_exception.dart';
import '../../../util/logger.dart';
import 'entity/hitter.dart';
import 'entity/hitting_stats.dart';
import 'supabase_hitter_converter.dart';

/// 全野手のIDと名前のリストを返すプロバイダー
final allHitterListProvider = riverpod.Provider<Future<List<HitterIdByName>>>(
  (ref) => ref.watch(hitterRepositoryProvider).fetchAllHitter(),
);

// TODO(me): エラーハンドリング要検討
class SupabaseHitterRepository implements HitterRepository {
  SupabaseHitterRepository(
    this.supabase,
  );

  final Supabase supabase;

  @override
  Future<HitterQuizUi> createHitterQuizUi(
    HitterSearchCondition searchCondition,
  ) async {
    // 検索条件に合う選手を1人取得
    final hitter = await searchHitter(searchCondition);

    // 取得した選手の成績を取得
    final statsList = await fetchHittingStats(hitter.id);

    // HitterQuizUi型に変換
    final quizUi = SupabaseHitterConverter().toHitterQuizUi(
      hitter,
      statsList,
      searchCondition.selectedStatsList,
    );

    return quizUi;
  }

  /// 条件に合う選手を1人検索する
  Future<Hitter> searchHitter(HitterSearchCondition searchCondition) async {
    try {
      final responses = await supabase.client
              .from('hitter_table')
              .select<dynamic>(
                'id, name, team, hasData, hitting_stats_table!inner(*)',
              )
              .eq('hasData', true)
              .filter('team', 'in', searchCondition.teamList)
              .gte('hitting_stats_table.試合', searchCondition.minGames)
              .gte('hitting_stats_table.安打', searchCondition.minHits)
              .gte('hitting_stats_table.本塁打', searchCondition.minHr)
          as List<dynamic>;

      // 検索条件に合致する選手がいない場合、例外を返す
      if (responses.isEmpty) {
        throw SupabaseException.notFound();
      }

      // ランダムで1人選出
      final chosenResponse =
          responses[Random().nextInt(responses.length)] as Map<String, dynamic>;
      final hitter = Hitter.fromJson(chosenResponse);

      return hitter;
    } on SupabaseException catch (e) {
      logger.e(e);
      rethrow;
    } on Exception catch (e) {
      logger.e(e);
      throw SupabaseException.unknown();
    }
  }

  /// playerIdから打撃成績のListを取得する
  Future<List<HittingStats>> fetchHittingStats(String playerId) async {
    final statsList = <HittingStats>[];
    try {
      final responses = await supabase.client
          .from('hitting_stats_table')
          .select<dynamic>()
          .eq('playerId', playerId) as List<dynamic>;

      for (final response in responses) {
        final stats = HittingStats.fromJson(response as Map<String, dynamic>);
        statsList.add(stats);
      }

      return statsList;
    } on Exception catch (e) {
      logger.e(e);
      throw SupabaseException.unknown();
    }
  }

  /// 解答を入力するテキストフィールドの検索用
  @override
  Future<List<HitterIdByName>> fetchAllHitter() async {
    try {
      final responses = await supabase.client
          .from('hitter_table')
          .select<dynamic>() as List<dynamic>;

      final allHitterList = <HitterIdByName>[];
      for (final response in responses) {
        final hitterMap = HitterIdByName.fromJson(
          response as Map<String, dynamic>,
        );
        allHitterList.add(hitterMap);
      }
      return allHitterList;
    } on Exception catch (e) {
      logger.e(e);
      throw SupabaseException.unknown();
    }
  }
}
