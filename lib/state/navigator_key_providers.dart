import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ダイアログ表示用のGlobalKeyを返すプロバイダー
/// .currentContext!でcontextを取得できる
final navigatorKeyProvider = Provider(
  (_) => GlobalKey<NavigatorState>(),
);

/// クイズ結果WidgetのGlobalKeyを返すプロバイダー
/// クイズ結果Widgetを画像化するために使用
final resultQuizWidgetKeyProvider = Provider.autoDispose(
  (_) => GlobalKey(),
);
