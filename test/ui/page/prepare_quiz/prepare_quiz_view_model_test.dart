import 'package:baseball_quiz_app/model/typeadapter/hitter_search_condition.dart';
import 'package:baseball_quiz_app/state/hitter_search_condition_state.dart';
import 'package:baseball_quiz_app/ui/page/prepare_quiz/prepare_quiz_view_model.dart';
import 'package:baseball_quiz_app/util/constant/hitter_search_condition_constant.dart';
import 'package:baseball_quiz_app/util/constant/hitting_stats/stats_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_hitter_search_condition.dart';

void main() {
  group('saveTeamList関数', () {
    test('teamListの要素が3つ', () {
      final teamList = ['千葉ロッテマリーンズ', '阪神タイガース', '読売ジャイアンツ'];
      final container = ProviderContainer(
        overrides: [
          hitterSearchConditionProvider.overrideWith(
            (ref) => dummyHitterSearchCondition1,
          ),
        ],
      );
      container.read(prepareQuizViewModelProvider).saveTeamList(teamList);
      final result = container.read(hitterSearchConditionProvider);

      expect(teamList, result.teamList);
    });

    test('teamListが空', () {
      final teamList = <String>[];
      final container = ProviderContainer(
        overrides: [
          hitterSearchConditionProvider.overrideWith(
            (ref) => dummyHitterSearchCondition1,
          ),
        ],
      );
      container.read(prepareQuizViewModelProvider).saveTeamList(teamList);
      final result = container.read(hitterSearchConditionProvider);

      expect(teamList, result.teamList);
    });
  });

  group('removeTeam関数', () {
    // アプリプレイ時には、このケースにならない想定
    test('球団数:1, index:0', () {
      final container = ProviderContainer(
        overrides: [
          hitterSearchConditionProvider.overrideWith(
            (ref) => dummyHitterSearchCondition1,
          ),
        ],
      );
      container.read(prepareQuizViewModelProvider).removeTeam(0);

      final result = container.read(hitterSearchConditionProvider);
      final expected = <String>[];

      expect(expected, result.teamList);
    });

    test('球団数:2, index:1', () {
      final container = ProviderContainer(
        overrides: [
          hitterSearchConditionProvider.overrideWith(
            (ref) => dummyHitterSearchCondition2,
          ),
        ],
      );
      container.read(prepareQuizViewModelProvider).removeTeam(1);

      final result = container.read(hitterSearchConditionProvider);
      final expected = ['千葉ロッテマリーンズ'];

      expect(expected, result.teamList);
    });

    // アプリプレイ時には、このケースにならない想定
    test('球団数:2, index:2（Listの範囲外）', () {
      final container = ProviderContainer(
        overrides: [
          hitterSearchConditionProvider.overrideWith(
            (ref) => dummyHitterSearchCondition2,
          ),
        ],
      );
      container.read(prepareQuizViewModelProvider).removeTeam(2);

      final result = container.read(hitterSearchConditionProvider);
      final expected = ['千葉ロッテマリーンズ', '阪神タイガース'];

      expect(expected, result.teamList);
    });
  });

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

  group('createRemovedTeamList関数', () {
    final viewModel = ProviderContainer().read(prepareQuizViewModelProvider);

    test('球団数:1, index:0', () {
      final teamList = ['千葉ロッテマリーンズ'];
      final result = viewModel.createRemovedTeamList(teamList, 0);
      final expected = <String>[];

      expect(expected, result);
    });

    // アプリプレイ時には、このケースにならない想定
    test('球団数:1, index:1（Listの範囲外）', () {
      final teamList = ['千葉ロッテマリーンズ'];
      final result = viewModel.createRemovedTeamList(teamList, 1);
      final expected = ['千葉ロッテマリーンズ'];

      expect(expected, result);
    });

    test('球団数:2, index:1', () {
      final teamList = ['千葉ロッテマリーンズ', '阪神タイガース'];
      final result = viewModel.createRemovedTeamList(teamList, 1);
      final expected = ['千葉ロッテマリーンズ'];

      expect(expected, result);
    });

    test('球団数:0, index:0', () {
      final teamList = <String>[];
      final result = viewModel.createRemovedTeamList(teamList, 0);
      final expected = <String>[];

      expect(expected, result);
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

  group('saveStatsList関数', () {
    test('5つの成績を指定', () {
      final container = ProviderContainer(
        overrides: [
          hitterSearchConditionProvider.overrideWith(
            (ref) => dummyHitterSearchCondition1,
          ),
        ],
      );
      final statsList = [
        StatsType.year.label,
        StatsType.team.label,
        StatsType.avg.label,
        StatsType.hr.label,
        StatsType.atBats.label,
      ];
      container.read(prepareQuizViewModelProvider).saveStatsList(statsList);
      final result = container.read(hitterSearchConditionProvider);

      expect(statsList, result.selectedStatsList);
    });
  });

  group('canChangeStatsState関数', () {
    final viewModel = ProviderContainer().read(prepareQuizViewModelProvider);

    test('選択可能上限数と同じ かつ すでに選択されている', () {
      final result = viewModel.canChangeStatsState(
        selectedLength: mustSelectStatsNum,
        isSelected: true,
      );
      expect(true, result);
    });

    test('選択可能上限数と同じ かつ 選択されていない', () {
      final result = viewModel.canChangeStatsState(
        selectedLength: mustSelectStatsNum,
        isSelected: false,
      );
      expect(false, result);
    });

    test('選択可能上限数未満', () {
      final result = viewModel.canChangeStatsState(
        selectedLength: mustSelectStatsNum - 1,
        isSelected: false,
      );
      expect(true, result);
    });

    // 実際のアプリではこのケースにならない想定
    test('選択可能上限数より多い', () {
      final result = viewModel.canChangeStatsState(
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
