// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_free_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$endAtAdFreePeriodStreamHash() =>
    r'6584b9c65896a8dae4e3a16da62dd45ac7262182';

/// 広告非表示期間の終了日時を取得する。
///
/// 広告非表示期間が設定されていない場合は `null` を返す。
///
/// Copied from [endAtAdFreePeriodStream].
@ProviderFor(endAtAdFreePeriodStream)
final endAtAdFreePeriodStreamProvider =
    AutoDisposeStreamProvider<DateTime?>.internal(
  endAtAdFreePeriodStream,
  name: r'endAtAdFreePeriodStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$endAtAdFreePeriodStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EndAtAdFreePeriodStreamRef = AutoDisposeStreamProviderRef<DateTime?>;
String _$isAdFreePeriodHash() => r'9a544532538e1a5d4323583496e827ae2f6472f4';

/// 広告非表示期間中かどうかを返す。
///
/// Copied from [isAdFreePeriod].
@ProviderFor(isAdFreePeriod)
final isAdFreePeriodProvider = AutoDisposeFutureProvider<bool>.internal(
  isAdFreePeriod,
  name: r'isAdFreePeriodProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAdFreePeriodHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsAdFreePeriodRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
