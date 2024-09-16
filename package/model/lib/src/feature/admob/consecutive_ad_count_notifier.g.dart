// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consecutive_ad_count_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$consecutiveAdCountNotifierHash() =>
    r'd29c5fec9b5e8273634c7ed363c1f3c1a6bb908f';

/// 連続してインタースティシャル広告を表示する回数を管理する [Notifier].
///
/// 問題が変わっても回数を引き継ぐ（リセットしない）ため、`keepAlive` を `true` にしている。
///
/// Copied from [ConsecutiveAdCountNotifier].
@ProviderFor(ConsecutiveAdCountNotifier)
final consecutiveAdCountNotifierProvider =
    NotifierProvider<ConsecutiveAdCountNotifier, int>.internal(
  ConsecutiveAdCountNotifier.new,
  name: r'consecutiveAdCountNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$consecutiveAdCountNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConsecutiveAdCountNotifier = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
