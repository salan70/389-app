import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}
