import 'package:baseball_quiz_app/model/typeadapter/hitter_search_condition.dart';
import 'package:baseball_quiz_app/state/hitter_search_condition_state.dart';
import 'package:baseball_quiz_app/ui/page/prepare_quiz/prepare_quiz_view_model.dart';
import 'package:baseball_quiz_app/util/constant/hitter_search_condition_constant.dart';
import 'package:baseball_quiz_app/util/constant/hitting_stats/stats_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('canRemoveTeam関数', () {
    test('選択中のteamListの長さが1', () {
      final hitterSearchCondition = HitterSearchCondition(
        teamList: [
          '千葉ロッテマリーンズ',
        ],
        minGames: 0,
        minHits: 0,
        minHr: 0,
        selectedStatsList: [
          StatsType.year.label,
          StatsType.team.label,
          StatsType.avg.label,
          StatsType.hr.label,
          StatsType.ops.label,
        ],
      );
      final container = ProviderContainer(
        overrides: [
          hitterSearchConditionProvider.overrideWith(
            (ref) => hitterSearchCondition,
          ),
        ],
      );
      final result =
          container.read(prepareQuizViewModelProvider).canRemoveTeam();
      expect(false, result);
    });

    test('選択中のteamListの長さが2', () {
      final hitterSearchCondition = HitterSearchCondition(
        teamList: [
          '千葉ロッテマリーンズ',
          '阪神タイガース',
        ],
        minGames: 0,
        minHits: 0,
        minHr: 0,
        selectedStatsList: [
          StatsType.year.label,
          StatsType.team.label,
          StatsType.avg.label,
          StatsType.hr.label,
          StatsType.ops.label,
        ],
      );
      final container = ProviderContainer(
        overrides: [
          hitterSearchConditionProvider.overrideWith(
            (ref) => hitterSearchCondition,
          ),
        ],
      );
      final result =
          container.read(prepareQuizViewModelProvider).canRemoveTeam();
      expect(true, result);
    });
  });

  group('isValidChoseTeamList関数', () {
    final viewModel = ProviderContainer().read(prepareQuizViewModelProvider);

    test('最小値-1', () {
      final result = viewModel.isValidChoseTeamList(minChoseTeamNum - 1);
      expect(false, result);
    });

    test('最小値', () {
      final result = viewModel.isValidChoseTeamList(minChoseTeamNum);
      expect(true, result);
    });

    test('最小値+1', () {
      final result = viewModel.isValidChoseTeamList(minChoseTeamNum + 1);
      expect(true, result);
    });
  });

  group('canChangeState関数', () {
    final viewModel = ProviderContainer().read(prepareQuizViewModelProvider);

    test('選択可能上限数と同じ かつ すでに選択されている', () {
      final result = viewModel.canChangeState(
        selectedLength: mustSelectStatsNum,
        isSelected: true,
      );
      expect(true, result);
    });

    test('選択可能上限数と同じ かつ 選択されていない', () {
      final result = viewModel.canChangeState(
        selectedLength: mustSelectStatsNum,
        isSelected: false,
      );
      expect(false, result);
    });

    test('選択可能上限数未満', () {
      final result = viewModel.canChangeState(
        selectedLength: mustSelectStatsNum - 1,
        isSelected: false,
      );
      expect(true, result);
    });

    // 実際のアプリではこのケースにならない想定
    test('選択可能上限数より多い', () {
      final result = viewModel.canChangeState(
        selectedLength: mustSelectStatsNum + 1,
        isSelected: false,
      );
      expect(false, result);
    });
  });

  group('isValidSelectedStatsList関数', () {
    final viewModel = ProviderContainer().read(prepareQuizViewModelProvider);

    test('選択可能上限数と同じ', () {
      final result = viewModel.isValidSelectedStatsList(mustSelectStatsNum);
      expect(true, result);
    });

    test('選択可能上限数より多い', () {
      final result = viewModel.isValidSelectedStatsList(mustSelectStatsNum + 1);
      expect(false, result);
    });

    test('選択可能上限数より多い', () {
      final result = viewModel.isValidSelectedStatsList(mustSelectStatsNum - 1);
      expect(false, result);
    });
  });
}
