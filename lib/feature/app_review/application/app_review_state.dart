import 'package:flutter_riverpod/flutter_riverpod.dart';

/// アプリレビューのリクエストを送るかどうか確認する処理の状態をAsyncValueとして返すプロバイダー
final checkRequestAppReviewStateProvider = StateProvider<AsyncValue<void>>(
  (_) => const AsyncValue.data(null),
);
