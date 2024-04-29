import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:model/src/feature/search_condition/application/search_condition_notifier.dart';
import 'package:model/src/feature/search_condition/domain/search_condition.dart';
import 'package:model/src/feature/search_condition/domain/search_condition_repository.dart';
import 'package:model/src/feature/search_condition/util/search_condition_constant.dart';
import 'package:model/src/util/enum/hitting_stats_type.dart';

import '../../../dummy_data/dummy_search_condition.dart';

class DummySearchConditionRepository implements SearchConditionRepository {
  DummySearchConditionRepository(this.searchCondition);

  final SearchCondition searchCondition;

  @override
  SearchCondition fetchSearchCondition() => searchCondition;

  @override
  void saveSearchCondition(SearchCondition searchCondition) {}
}

void main() {
  final container = ProviderContainer(
    overrides: [
      searchConditionRepositoryProvider.overrideWithValue(
        DummySearchConditionRepository(dummySearchCondition1),
      ),
    ],
  );
  final notifier = container.read(searchConditionNotifierProvider.notifier);

  setUp(() {
    container.invalidate(searchConditionNotifierProvider);
  });

  group('saveTeamList関数', () {
    test('teamListの要素が3つ', () {
      // * Arrange
      final teamList = ['千葉ロッテマリーンズ', '阪神タイガース', '読売ジャイアンツ'];

      // * Act
      notifier.updateTeamList(teamList);

      // * Assert
      final actual = notifier.state;
      expect(actual.teamList, teamList);
    });

    test('teamListが空', () {
      // * Arrange
      final teamList = <String>[];

      // * Act
      notifier.updateTeamList(teamList);

      // * Assert
      final actual = notifier.state;
      expect(actual.teamList, teamList);
    });
  });

  group('removeTeam関数', () {
    // アプリプレイ時には、このケースにならない想定
    test('球団数:1, index:0', () {
      // * Act
      notifier.removeTeam(0);

      // * Assert
      final actual = notifier.state;
      final expected = <String>[];
      expect(actual.teamList, expected);
    });

    test('球団数:2, index:1', () {
      // * Arrange
      final container = ProviderContainer(
        overrides: [
          searchConditionRepositoryProvider.overrideWithValue(
            DummySearchConditionRepository(dummySearchCondition2),
          ),
        ],
      );
      final notifier = container.read(searchConditionNotifierProvider.notifier);

      // * Act
      notifier.removeTeam(1);

      // * Assert
      final actual = notifier.state;
      final expected = ['千葉ロッテマリーンズ'];
      expect(actual.teamList, expected);
    });

    // アプリプレイ時には、このケースにならない想定
    test('球団数:2, index:2（Listの範囲外）', () {
      // * Arrange
      final container = ProviderContainer(
        overrides: [
          searchConditionRepositoryProvider.overrideWithValue(
            DummySearchConditionRepository(dummySearchCondition2),
          ),
        ],
      );
      final notifier = container.read(searchConditionNotifierProvider.notifier);

      // * Act
      notifier.removeTeam(2);

      // * Assert
      final actual = notifier.state;
      final expected = ['千葉ロッテマリーンズ', '阪神タイガース'];
      expect(actual.teamList, expected);
    });
  });

  group('canRemoveTeam関数', () {
    test('選択中のteamListの長さが1', () {
      // * Arrange
      final searchCondition = SearchCondition(
        teamList: [
          '千葉ロッテマリーンズ',
        ],
        minGames: 0,
        minHits: 0,
        minHr: 0,
        selectedStatsList: [
          StatsType.team.label,
          StatsType.avg.label,
          StatsType.hr.label,
          StatsType.ops.label,
        ],
      );
      final container = ProviderContainer(
        overrides: [
          searchConditionRepositoryProvider.overrideWithValue(
            DummySearchConditionRepository(searchCondition),
          ),
        ],
      );
      final notifier = container.read(searchConditionNotifierProvider.notifier);

      // * Act
      final actual = notifier.canRemoveTeam();

      // * Assert
      expect(actual, false);
    });

    test('選択中のteamListの長さが2', () {
      // * Arrange
      final searchCondition = SearchCondition(
        teamList: [
          '千葉ロッテマリーンズ',
          '阪神タイガース',
        ],
        minGames: 0,
        minHits: 0,
        minHr: 0,
        selectedStatsList: [
          StatsType.team.label,
          StatsType.avg.label,
          StatsType.hr.label,
          StatsType.ops.label,
        ],
      );
      final container = ProviderContainer(
        overrides: [
          searchConditionRepositoryProvider.overrideWithValue(
            DummySearchConditionRepository(searchCondition),
          ),
        ],
      );
      final notifier = container.read(searchConditionNotifierProvider.notifier);

      // * Act
      final actual = notifier.canRemoveTeam();

      // * Assert
      expect(actual, true);
    });
  });

  group('createRemovedTeamList関数', () {
    test('球団数:1, index:0', () {
      // * Arrange
      final teamList = ['千葉ロッテマリーンズ'];

      // * Act
      final actual = notifier.createRemovedTeamList(teamList, 0);

      // * Assert
      final expected = <String>[];
      expect(actual, expected);
    });

    // アプリプレイ時には、このケースにならない想定
    test('球団数:1, index:1（Listの範囲外）', () {
      // * Arrange
      final teamList = ['千葉ロッテマリーンズ'];

      // * Act
      final actual = notifier.createRemovedTeamList(teamList, 1);

      // * Assert
      final expected = ['千葉ロッテマリーンズ'];
      expect(actual, expected);
    });

    test('球団数:2, index:1', () {
      // * Arrange
      final teamList = ['千葉ロッテマリーンズ', '阪神タイガース'];

      // * Act
      final actual = notifier.createRemovedTeamList(teamList, 1);

      // * Assert
      final expected = ['千葉ロッテマリーンズ'];
      expect(actual, expected);
    });

    test('球団数:0, index:0', () {
      // * Arrange
      final teamList = <String>[];

      // * Act
      final actual = notifier.createRemovedTeamList(teamList, 0);

      // * Assert
      final expected = <String>[];
      expect(actual, expected);
    });
  });

  group('isValidChoseTeamList関数', () {
    final notifier =
        ProviderContainer().read(searchConditionNotifierProvider.notifier);

    test('最小値-1', () {
      final actual = notifier.isValidTeamList(minChoseTeamNum - 1);
      expect(actual, false);
    });

    test('最小値', () {
      final actual = notifier.isValidTeamList(minChoseTeamNum);
      expect(actual, true);
    });

    test('最小値+1', () {
      final actual = notifier.isValidTeamList(minChoseTeamNum + 1);
      expect(actual, true);
    });
  });

  group('saveStatsList関数', () {
    test('5つの成績を指定', () {
      // * Arrange
      final statsList = [
        StatsType.team.label,
        StatsType.avg.label,
        StatsType.hr.label,
        StatsType.atBats.label,
      ];

      // * Act
      notifier.updateSelectedStatsList(statsList);

      // * Assert
      final actual = notifier.state;
      expect(actual.selectedStatsList, statsList);
    });
  });

  group('canChangeStatsState関数', () {
    test('選択可能上限数と同じ かつ すでに選択されている', () {
      // * Act
      final actual = notifier.canChangeStatsState(
        selectedLength: mustSelectStatsNum,
        isSelected: true,
      );

      // * Assert
      expect(actual, true);
    });

    test('選択可能上限数と同じ かつ 選択されていない', () {
      // * Act
      final actual = notifier.canChangeStatsState(
        selectedLength: mustSelectStatsNum,
        isSelected: false,
      );

      // * Assert
      expect(actual, false);
    });

    test('選択可能上限数未満', () {
      // * Act
      final actual = notifier.canChangeStatsState(
        selectedLength: mustSelectStatsNum - 1,
        isSelected: false,
      );

      // * Assert
      expect(actual, true);
    });

    // 実際のアプリではこのケースにならない想定
    test('選択可能上限数より多い', () {
      // * Act
      final actual = notifier.canChangeStatsState(
        selectedLength: mustSelectStatsNum + 1,
        isSelected: false,
      );

      // * Assert
      expect(actual, false);
    });
  });

  group('isValidSelectedStatsList関数', () {
    test('選択可能上限数と同じ', () {
      // * Act
      final actual = notifier.isValidSelectedStatsList(mustSelectStatsNum);

      // * Assert
      expect(actual, true);
    });

    test('選択可能上限数より多い', () {
      // * Act
      final actual = notifier.isValidSelectedStatsList(mustSelectStatsNum + 1);

      // * Assert
      expect(actual, actual);
    });

    test('選択可能上限数より多い', () {
      // * Act
      final actual = notifier.isValidSelectedStatsList(mustSelectStatsNum - 1);

      // * Assert
      expect(actual, actual);
    });
  });
}
