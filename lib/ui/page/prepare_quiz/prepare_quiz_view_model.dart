import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/hitter_search_condition_state.dart';
import '../../../../util/constant/hitter_search_condition_constant.dart';

final prepareQuizViewModelProvider =
    Provider.autoDispose<PrepareQuizViewModel>(PrepareQuizViewModel.new);

class PrepareQuizViewModel {
  PrepareQuizViewModel(
    this.ref,
  );

  final Ref ref;

  // TODO(me): テスト書くことを検討する
  /// 選択した球団のリストを保存する
  void saveTeamList(List<Object?> selectedList) {
    final searchCondition = ref.read(hitterSearchConditionProvider.notifier);
    final teamList = selectedList.cast<String>();
    searchCondition.state = searchCondition.state.copyWith(teamList: teamList);
  }

  /// 球団を取り除けるか判別する
  /// 選択中のteamListの長さが2以上の場合に取り除ける
  /// （取り除くとteamListが空になる場合取り除けない）
  bool canRemoveTeam() {
    return ref.read(hitterSearchConditionProvider).teamList.length > 1;
  }

  // TODO(me): テスト書くことを検討する
  /// 選択した球団を取り除く
  void removeTeam(int selectedIndex) {
    final searchCondition = ref.read(hitterSearchConditionProvider.notifier);

    final teamList = searchCondition.state.teamList;
    final removedTeamList = createRemovedTeamList(teamList, selectedIndex);

    searchCondition.state =
        searchCondition.state.copyWith(teamList: removedTeamList);
  }

  /// 引数のteamListから引数のIndexを除いたlistを作成する
  /// teamListに対してremoveAt()が使えない（immutableだから？）ため、
  /// この関数を使う
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

  // TODO(me): テスト書くことを検討する
  void saveStatsList(List<String> selectedList) {
    final searchCondition = ref.read(hitterSearchConditionProvider.notifier);
    searchCondition.state =
        searchCondition.state.copyWith(selectedStatsList: selectedList);
  }

  /// 成績をタップ時に状態（選択/未選択）を変更できるか判別
  bool canChangeState({required int selectedLength, required bool isSelected}) {
    if (selectedLength == mustSelectStatsNum && isSelected) {
      return true;
    }
    return selectedLength < mustSelectStatsNum;
  }

  bool isValidSelectedStatsList(int listLength) {
    return listLength == mustSelectStatsNum;
  }
}
