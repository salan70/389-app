import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/hitter.dart';
import '../infrastructure/hitter_repository.dart';

part 'answer_state.g.dart';

/// 全野手のIDと名前のリストを返すプロバイダー
@riverpod
Future<List<Hitter>> allHitterList(AllHitterListRef ref) async =>
    ref.watch(hitterRepositoryProvider).fetchAllHitter();
