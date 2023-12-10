import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/hitter.dart';
import '../domain/hitter_repository.dart';

part 'answer_state.g.dart';

// todo stateProvider
/// クイズ回答用のテキストフィールドで使用するTextEditingControllerを返す
final answerTextFieldProvider = StateProvider((ref) => TextEditingController());

// todo stateProvider
/// 回答した選手を返す
final submittedHitterProvider = StateProvider<Hitter?>((ref) => null);

/// 全野手のIDと名前のリストを返すプロバイダー
@riverpod
Future<List<Hitter>> allHitterList(AllHitterListRef ref) async =>
    ref.watch(hitterRepositoryProvider).fetchAllHitter();
