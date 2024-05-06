import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/router/app_router.dart';
import '../../core/util/controller_mixin.dart';

part 'quiz_setting_page_controller.freezed.dart';
part 'quiz_setting_page_controller.g.dart';

@freezed
class QuizSettingPageState with _$QuizSettingPageState {
  const factory QuizSettingPageState({
    required SearchCondition searchCondition,
  }) = _QuizSettingPageState;
}

@riverpod
class QuizSettingPageController extends _$QuizSettingPageController
    with ControllerMixin {
  @override
  QuizSettingPageState build() {
    final searchCondition = ref.watch(searchConditionProvider);

    return QuizSettingPageState(searchCondition: searchCondition);
  }

  /// state.teamList  を更新する。
  void updateTeamList(List<Object?> selectedTeamList) {
    final teamList = selectedTeamList.cast<String>();
    state = state.copyWith(
      searchCondition: state.searchCondition.copyWith(teamList: teamList),
    );
  }

  /// state.minGames を更新する。
  void updateMinGames(int minGames) {
    state = state.copyWith(
      searchCondition: state.searchCondition.copyWith(minGames: minGames),
    );
  }

  /// state.minHits を更新する。
  void updateMinHits(int minHits) {
    state = state.copyWith(
      searchCondition: state.searchCondition.copyWith(minHits: minHits),
    );
  }

  /// state.minHr を更新する。
  void updateMinHr(int minHr) {
    state = state.copyWith(
      searchCondition: state.searchCondition.copyWith(minHr: minHr),
    );
  }

  /// state.selectedStatsList を更新する。
  void updateSelectedStatsList(List<String> selectedStatsList) {
    state = state.copyWith(
      searchCondition: state.searchCondition.copyWith(
        selectedStatsList: selectedStatsList,
      ),
    );
  }

  void chipOnDelete(int index) {
    if (_canRemoveTeam) {
      _removeTeam(index);
    }
  }

  /// 「クイズをプレイする旨のボタン」をタップした際の処理。
  Future<void> onTapPlayNormalQuiz() async {
    await executeWithOverlayLoading(
      ref,
      action: () async {
        // searchCondition を repository へ保存する。
        _saveSearchCondition();

        // クイズ取得時のエラーをキャッチできるよう、ここで `hitterQuizStateProvider` を取得しておく。
        await ref.read(hitterQuizStateProvider.future);

        // Analytics に search_condition を送信する。
        await ref.read(analyticsServiceProvider).logSearchCondition();
      },
      onLoadingComplete: () =>
          ref.read(appRouterProvider).push(PlayNormalQuizRoute()),
    );
  }

  /// 球団を取り除けるか判別する。
  ///
  /// state.teamList の長さが2以上の場合に取り除ける。
  /// （取り除くと空になる場合取り除けない。）
  bool get _canRemoveTeam => state.searchCondition.teamList.length > 1;

  /// 選択した球団を取り除く。
  void _removeTeam(int selectedIndex) {
    final teamList = state.searchCondition.teamList;
    final removedTeamList = createRemovedTeamList(teamList, selectedIndex);

    state = state.copyWith(
      searchCondition: state.searchCondition.copyWith(
        teamList: removedTeamList,
      ),
    );
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
  void _saveSearchCondition() {
    ref
        .read(searchConditionRepositoryProvider)
        .saveSearchCondition(state.searchCondition);

    // TODO(me): ここの invalidate によって、望ましくない UI のリビルドが発生しないか確認する。
    ref.invalidate(searchConditionProvider);
  }
}
