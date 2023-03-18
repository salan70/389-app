import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// クイズ回答用のテキストフィールドで使用するTextEditingControllerを返す
final answerTextFieldProvider = StateProvider((ref) => TextEditingController());
