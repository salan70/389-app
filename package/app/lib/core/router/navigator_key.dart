import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigator_key.g.dart';

@riverpod
GlobalKey<NavigatorState> navigatorKey(
  NavigatorKeyRef ref,
) =>
    GlobalKey<NavigatorState>();
