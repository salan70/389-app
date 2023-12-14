// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_quiz_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dailyQuizHash() => r'15c4f7f84006434ab4a755db85f53ece711cbe92';

/// [DailyQuiz] を取得して保持する。
///
/// 有効な [DailyQuiz] が存在しなかった場合は、 `null` を返す。
///
/// Copied from [dailyQuiz].
@ProviderFor(dailyQuiz)
final dailyQuizProvider = AutoDisposeFutureProvider<DailyQuiz?>.internal(
  dailyQuiz,
  name: r'dailyQuizProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dailyQuizHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DailyQuizRef = AutoDisposeFutureProviderRef<DailyQuiz?>;
String _$isPlayedDailyQuizHash() => r'29dc4d02acf626854b796780fe83ff495a196f06';

/// dailyQuiz をプレイ済みかどうかを返す。
///
/// Copied from [isPlayedDailyQuiz].
@ProviderFor(isPlayedDailyQuiz)
final isPlayedDailyQuizProvider = AutoDisposeFutureProvider<bool>.internal(
  isPlayedDailyQuiz,
  name: r'isPlayedDailyQuizProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isPlayedDailyQuizHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsPlayedDailyQuizRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
