import 'package:flutter_riverpod/flutter_riverpod.dart';

// todo stateProvider
/// クイズ結果関連の関数の処理状態をAsyncValueとして返すプロバイダー
final checkNeedUpdateStateProvider = StateProvider<AsyncValue<void>>(
  (_) => const AsyncValue.data(null),
);
