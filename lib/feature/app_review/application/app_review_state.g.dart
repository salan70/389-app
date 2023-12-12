// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_review_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewHistoryHash() => r'f469590f69abec63ef22c019d9717b30bc6e7e70';

/// [ReviewHistory] を取得する。
///
/// 存在しない場合は null を返す。
///
/// Copied from [reviewHistory].
@ProviderFor(reviewHistory)
final reviewHistoryProvider =
    AutoDisposeFutureProvider<ReviewHistory?>.internal(
  reviewHistory,
  name: r'reviewHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reviewHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReviewHistoryRef = AutoDisposeFutureProviderRef<ReviewHistory?>;
String _$shouldRequestReviewHash() =>
    r'ed4f890c9edb1bb6f23d8ed3f1e016cb797791c0';

/// レビューを要求するかどうかを返すプロバイダー。
///
/// Copied from [shouldRequestReview].
@ProviderFor(shouldRequestReview)
final shouldRequestReviewProvider = AutoDisposeFutureProvider<bool>.internal(
  shouldRequestReview,
  name: r'shouldRequestReviewProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$shouldRequestReviewHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ShouldRequestReviewRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
