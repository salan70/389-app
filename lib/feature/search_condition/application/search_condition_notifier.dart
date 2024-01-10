import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/search_condition.dart';
import '../domain/search_condition_repository.dart';
import '../util/search_condition_constant.dart';

part 'search_condition_notifier.g.dart';

@riverpod
class SearchConditionNotifier extends _$SearchConditionNotifier {
  @override
  SearchCondition build() =>
      ref.watch(searchConditionRepositoryProvider).fetchSearchCondition();

  /// state.teamList  を更新する。
  void updateTeamList(List<Object?> selectedTeamList) {
    final teamList = selectedTeamList.cast<String>();
    state = state.copyWith(teamList: teamList);
  }

  /// state.minGames を更新する。
  void updateMinGames(int minGames) {
    state = state.copyWith(minGames: minGames);
  }

  /// state.minHits を更新する。
  void updateMinHits(int minHits) {
    state = state.copyWith(minHits: minHits);
  }

  /// state.minHr を更新する。
  void updateMinHr(int minHr) {
    state = state.copyWith(minHr: minHr);
  }

  /// state.selectedStatsList を更新する。
  void updateSelectedStatsList(List<String> selectedStatsList) {
    state = state.copyWith(selectedStatsList: selectedStatsList);
  }

  /// 球団を取り除けるか判別する。
  ///
  /// state.teamList の長さが2以上の場合に取り除ける。
  /// （取り除くと空になる場合取り除けない。）
  bool canRemoveTeam() => state.teamList.length > 1;

  /// 選択した球団を取り除く。
  void removeTeam(int selectedIndex) {
    final teamList = state.teamList;
    final removedTeamList = createRemovedTeamList(teamList, selectedIndex);

    state = state.copyWith(teamList: removedTeamList);
  }

  /// [teamList] から [removeIndex] の要素を除いたリストを作成する。
  ///
  /// state.teamList に対して `removeAt()` が
  /// 使えないため、この関数を使う。
  @visibleForTesting
  List<String> createRemovedTeamList(List<String> teamList, int removeIndex) {
    if (teamList.length <= removeIndex) {
      // ここに入ることはない想定
      return teamList;
    }

    final removedTeamList = <String>[];
    for (final team in teamList) {
      if (team != teamList[removeIndex]) {
        removedTeamList.add(team);
      }
    }
    return removedTeamList;
  }

  /// [listLength] が teamList として有効かどうか。
  bool isValidTeamList(int listLength) => listLength >= minChoseTeamNum;

  /// [listLength] が selectedStatsList として有効かどうか。
  bool isValidSelectedStatsList(int listLength) =>
      listLength == mustSelectStatsNum;

  /// 成績をタップ時に状態（選択/未選択）を変更できるかどうか。
  bool canChangeStatsState({
    required int selectedLength,
    required bool isSelected,
  }) {
    if (selectedLength == mustSelectStatsNum && isSelected) {
      return true;
    }
    return selectedLength < mustSelectStatsNum;
  }

  /// [SearchCondition] を repository に保存する。
  void save() =>
      ref.read(searchConditionRepositoryProvider).saveSearchCondition(state);
}
