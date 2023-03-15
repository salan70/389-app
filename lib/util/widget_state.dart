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
