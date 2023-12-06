import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../util/logger.dart';
import '../../search_condition/domain/search_condition.dart';

// TODO(me): `material.dart` に依存しているため、他のファイルに移動したい。
final analyticsObserverProvider =
    Provider.autoDispose<RouteObserver<ModalRoute<dynamic>>>((ref) {
  return FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
});

/// [AnalyticsService] プロバイダー
final analyticsServiceProvider = Provider(AnalyticsService.new);

/// Analytics 関連の処理を行うサービスクラス。
class AnalyticsService {
  const AnalyticsService(this.ref);

  final Ref ref;

  Future<void> logSearchCondition(SearchCondition searchCondition) async {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: 'search_condition',
        parameters: {
          'team_list': _formatListForParameter(searchCondition.teamList),
          'min_games': searchCondition.minGames,
          'min_hits': searchCondition.minHits,
          'min_hr': searchCondition.minHr,
          'selected_stats_list':
              _formatListForParameter(searchCondition.selectedStatsList),
        },
      );
    } on Exception catch (e, s) {
      logger.e('検索条件のログを送信時にエラーが発生。', e, s);
    }
  }

  Future<void> logTapButton(String buttonName) async {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: 'tap_button',
        parameters: {
          'button_name': buttonName,
        },
      );
    } on Exception catch (e, s) {
      logger.e('ボタンタップのログを送信時にエラーが発生。', e, s);
    }
  }

  /// `List<String>` を Analytics の log として送信するための文字列に変換する。
  ///
  /// 具体的には、各要素の先頭2文字を取り出し、それらをカンマとスペースで区切って連結する。
  String _formatListForParameter(List<String> stringList) {
    return stringList.map((s) => s.substring(0, 2)).join(', ');
  }
}
