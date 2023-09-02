import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/hitter.dart';
import '../domain/hitter_repository.dart';

/// クイズ回答用のテキストフィールドで使用するTextEditingControllerを返す
final answerTextFieldProvider = StateProvider((ref) => TextEditingController());

/// 回答した選手を返す
final submittedHitterProvider = StateProvider<Hitter?>((ref) => null);

/// 全野手のIDと名前のリストを返すプロバイダー
final allHitterListProvider = Provider<Future<List<Hitter>>>(
  (ref) => ref.watch(hitterRepositoryProvider).fetchAllHitter(),
);
