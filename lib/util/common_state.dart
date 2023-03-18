import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 処理の状態をAsyncValueとして返すプロバイダー
final commonFunctionStateProvider = StateProvider<AsyncValue<void>>(
  (_) => const AsyncValue.data(null),
);
