import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// このファイルでは、GlobalKeyやTextEditingControllerなど、
// Widget（View）と密に関係する状態を返すプロバイダーを定義する。
//
// presentation層に定義するか迷った。

/// ダイアログ表示用のGlobalKeyを返す
/// .currentContext!でcontextを取得できる
final navigatorKeyProvider = Provider(
  (_) => GlobalKey<NavigatorState>(),
);

/// クイズ結果WidgetのGlobalKeyを返す
/// クイズ結果Widgetを画像化するために使用
final resultQuizWidgetKeyProvider = Provider.autoDispose(
  (_) => GlobalKey(),
);

/// クイズ回答用のテキストフィールドで使用するTextEditingControllerを返す
final answerTextFieldProvider = StateProvider((ref) => TextEditingController());
