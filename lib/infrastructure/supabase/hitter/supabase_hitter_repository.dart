import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/entity/hitter.dart';
import '../../../domain/entity/hitter_quiz.dart';
import '../../../domain/entity/search_condition.dart';
import '../../../domain/repository/hitter_repository.dart';
import '../../../util/exception/supabase_exception.dart';
import '../../../util/logger.dart';
import 'entity/hitting_stats.dart';
import 'entity/supabase_hitter.dart';
import 'supabase_hitter_converter.dart';

/// 全野手のIDと名前のリストを返すプロバイダー
final allHitterListProvider = riverpod.Provider<Future<List<Hitter>>>(
  (ref) => ref.watch(hitterRepositoryProvider).fetchAllHitter(),
);

// TODO(me): エラーハンドリング要検討
class SupabaseHitterRepository implements HitterRepository {
  SupabaseHitterRepository(
    this.supabase,
  );

  final Supabase supabase;

  @override
  Future<HitterQuiz> createHitterQuiz(
    SearchCondition searchCondition,
  ) async {
    // 検索条件に合う選手を1人取得
    final supabaseHitter = await searchHitter(searchCondition);

    // 取得した選手の成績を取得
    final statsList = await fetchHittingStats(supabaseHitter.id);

    // HitterQuiz型に変換
    final hitterQuiz = SupabaseHitterConverter().toHitterQuiz(
      supabaseHitter,
      statsList,
      searchCondition.selectedStatsList,
    );

    return hitterQuiz;
  }

  /// 条件に合う選手を1人検索する
  Future<SupabaseHitter> searchHitter(
    SearchCondition searchCondition,
  ) async {
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
      final supabaseHitter = SupabaseHitter.fromJson(chosenResponse);

      return supabaseHitter;
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
  /// 全選手の名前とIDを取得する
  @override
  Future<List<Hitter>> fetchAllHitter() async {
    try {
      final responses = await supabase.client
          .from('hitter_table')
          .select<dynamic>() as List<dynamic>;

      final allHitterList = <Hitter>[];
      for (final response in responses) {
        final hitterMap = Hitter.fromJson(
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
