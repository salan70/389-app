// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$normalQuizResultListHash() =>
    r'e04452c0f9007177982ce133f933a1198142e4cd';

/// normalQuiz の結果をリストで返すプロバイダー。
///
/// Copied from [normalQuizResultList].
@ProviderFor(normalQuizResultList)
final normalQuizResultListProvider =
    AutoDisposeFutureProvider<List<HitterQuizResult>>.internal(
  normalQuizResultList,
  name: r'normalQuizResultListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$normalQuizResultListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NormalQuizResultListRef
    = AutoDisposeFutureProviderRef<List<HitterQuizResult>>;
String _$dailyQuizResultHash() => r'7fab6ef95826b30b4be1f36e5008e199b51d2a1c';

/// dailyQuiz の結果を返すプロバイダー。
///
/// Copied from [dailyQuizResult].
@ProviderFor(dailyQuizResult)
final dailyQuizResultProvider =
    AutoDisposeFutureProvider<DailyHitterQuizResult>.internal(
  dailyQuizResult,
  name: r'dailyQuizResultProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dailyQuizResultHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DailyQuizResultRef
    = AutoDisposeFutureProviderRef<DailyHitterQuizResult>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
