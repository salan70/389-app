import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../util/search_condition_constant.dart';
import 'search_condition_state.dart';

final searchConditionServiceProvider =
    Provider.autoDispose<SearchConditionService>(
  SearchConditionService.new,
);

class SearchConditionService {
  SearchConditionService(
    this.ref,
  );

  final Ref ref;

  /// 選択した球団のリストを保存する
  void saveTeamList(List<Object?> selectedTeamList) {
    final searchCondition = ref.read(searchConditionProvider.notifier);
    final teamList = selectedTeamList.cast<String>();
    searchCondition.state = searchCondition.state.copyWith(teamList: teamList);
  }

  /// 球団を取り除けるか判別する
  /// 選択中のteamListの長さが2以上の場合に取り除ける
  /// （取り除くとteamListが空になる場合取り除けない）
  bool canRemoveTeam() {
    return ref.read(searchConditionProvider).teamList.length > 1;
  }

  /// 選択した球団を取り除く
  void removeTeam(int selectedIndex) {
    final searchCondition = ref.read(searchConditionProvider.notifier);

    final teamList = searchCondition.state.teamList;
    final removedTeamList = createRemovedTeamList(teamList, selectedIndex);

    searchCondition.state =
        searchCondition.state.copyWith(teamList: removedTeamList);
  }

  /// 引数のteamListから引数のIndexを除いたlistを作成する
  /// searchCondition.state.teamListに対してremoveAt()が
  /// 使えない（immutableだから？）ため、この関数を使う
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

  bool isValidChoseTeamList(int listLength) {
    return listLength >= minChoseTeamNum;
  }

  void saveSelectedStatsList(List<String> selectedStatsList) {
    final searchCondition = ref.read(searchConditionProvider.notifier);
    searchCondition.state =
        searchCondition.state.copyWith(selectedStatsList: selectedStatsList);
  }

  /// 成績をタップ時に状態（選択/未選択）を変更できるか判別
  bool canChangeStatsState({
    required int selectedLength,
    required bool isSelected,
  }) {
    if (selectedLength == mustSelectStatsNum && isSelected) {
      return true;
    }
    return selectedLength < mustSelectStatsNum;
  }

  bool isValidSelectedStatsList(int listLength) {
    return listLength == mustSelectStatsNum;
  }
}
