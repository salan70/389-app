import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/hitter.dart';

/// クイズ回答用のテキストフィールドで使用するTextEditingControllerを返す
final answerTextFieldProvider = StateProvider((ref) => TextEditingController());

/// 回答した選手を返す
final submittedHitterProvider = StateProvider<Hitter?>((ref) => null);
