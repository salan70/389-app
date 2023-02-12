import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/hitter_quiz_ui.dart';

// hitterQuizUiをAsyncValueとして返すプロバイダー
final hitterQuizUiStateProvider = StateProvider<AsyncValue<HitterQuizUi?>>(
  (_) => const AsyncValue.data(null),
);
