// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_quiz_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dailyQuizHash() => r'18c2f94458a044b3ea27613267b57d8e34c5fb12';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// [questionedAt] に出題された [DailyQuiz] を取得して保持する。
///
/// 有効な [DailyQuiz] が存在しなかった場合は、 `null` を返す。
///
/// Copied from [dailyQuiz].
@ProviderFor(dailyQuiz)
const dailyQuizProvider = DailyQuizFamily();

/// [questionedAt] に出題された [DailyQuiz] を取得して保持する。
///
/// 有効な [DailyQuiz] が存在しなかった場合は、 `null` を返す。
///
/// Copied from [dailyQuiz].
class DailyQuizFamily extends Family<AsyncValue<DailyQuiz?>> {
  /// [questionedAt] に出題された [DailyQuiz] を取得して保持する。
  ///
  /// 有効な [DailyQuiz] が存在しなかった場合は、 `null` を返す。
  ///
  /// Copied from [dailyQuiz].
  const DailyQuizFamily();

  /// [questionedAt] に出題された [DailyQuiz] を取得して保持する。
  ///
  /// 有効な [DailyQuiz] が存在しなかった場合は、 `null` を返す。
  ///
  /// Copied from [dailyQuiz].
  DailyQuizProvider call(
    DateTime questionedAt,
  ) {
    return DailyQuizProvider(
      questionedAt,
    );
  }

  @override
  DailyQuizProvider getProviderOverride(
    covariant DailyQuizProvider provider,
  ) {
    return call(
      provider.questionedAt,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dailyQuizProvider';
}

/// [questionedAt] に出題された [DailyQuiz] を取得して保持する。
///
/// 有効な [DailyQuiz] が存在しなかった場合は、 `null` を返す。
///
/// Copied from [dailyQuiz].
class DailyQuizProvider extends AutoDisposeFutureProvider<DailyQuiz?> {
  /// [questionedAt] に出題された [DailyQuiz] を取得して保持する。
  ///
  /// 有効な [DailyQuiz] が存在しなかった場合は、 `null` を返す。
  ///
  /// Copied from [dailyQuiz].
  DailyQuizProvider(
    DateTime questionedAt,
  ) : this._internal(
          (ref) => dailyQuiz(
            ref as DailyQuizRef,
            questionedAt,
          ),
          from: dailyQuizProvider,
          name: r'dailyQuizProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dailyQuizHash,
          dependencies: DailyQuizFamily._dependencies,
          allTransitiveDependencies: DailyQuizFamily._allTransitiveDependencies,
          questionedAt: questionedAt,
        );

  DailyQuizProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.questionedAt,
  }) : super.internal();

  final DateTime questionedAt;

  @override
  Override overrideWith(
    FutureOr<DailyQuiz?> Function(DailyQuizRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DailyQuizProvider._internal(
        (ref) => create(ref as DailyQuizRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        questionedAt: questionedAt,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DailyQuiz?> createElement() {
    return _DailyQuizProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DailyQuizProvider && other.questionedAt == questionedAt;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, questionedAt.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DailyQuizRef on AutoDisposeFutureProviderRef<DailyQuiz?> {
  /// The parameter `questionedAt` of this provider.
  DateTime get questionedAt;
}

class _DailyQuizProviderElement
    extends AutoDisposeFutureProviderElement<DailyQuiz?> with DailyQuizRef {
  _DailyQuizProviderElement(super.provider);

  @override
  DateTime get questionedAt => (origin as DailyQuizProvider).questionedAt;
}

String _$isPlayedTodaysDailyQuizHash() =>
    r'783141988985859d92b20a6d15ce2584e3758815';

/// dailyQuiz をプレイ済みかどうかを返す。
///
/// Copied from [isPlayedTodaysDailyQuiz].
@ProviderFor(isPlayedTodaysDailyQuiz)
final isPlayedTodaysDailyQuizProvider =
    AutoDisposeFutureProvider<bool>.internal(
  isPlayedTodaysDailyQuiz,
  name: r'isPlayedTodaysDailyQuizProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isPlayedTodaysDailyQuizHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsPlayedTodaysDailyQuizRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
