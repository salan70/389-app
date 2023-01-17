import 'package:flutter_riverpod/flutter_riverpod.dart';

// クイズに正解しているかどうかを返すプロバイダー
final isCorrectQuizStateProvider = StateProvider<bool>(
  (_) => false,
);
