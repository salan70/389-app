// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hitter_quiz_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hitterQuizNotifierHash() =>
    r'f706c41f29d786a7b7217f8a38743e02b96bd907';

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

abstract class _$HitterQuizNotifier
    extends BuildlessAutoDisposeAsyncNotifier<HitterQuiz> {
  late final QuizType quizType;
  late final DateTime? questionedAt;

  FutureOr<HitterQuiz> build(
    QuizType quizType, {
    required DateTime? questionedAt,
  });
}

/// [HitterQuiz] を保持する。
///
/// [quizType] に [QuizType.daily] を指定する場合、
/// [questionedAt] に DailyQuiz の出題日を指定すること。
///
/// Copied from [HitterQuizNotifier].
@ProviderFor(HitterQuizNotifier)
const hitterQuizNotifierProvider = HitterQuizNotifierFamily();

/// [HitterQuiz] を保持する。
///
/// [quizType] に [QuizType.daily] を指定する場合、
/// [questionedAt] に DailyQuiz の出題日を指定すること。
///
/// Copied from [HitterQuizNotifier].
class HitterQuizNotifierFamily extends Family<AsyncValue<HitterQuiz>> {
  /// [HitterQuiz] を保持する。
  ///
  /// [quizType] に [QuizType.daily] を指定する場合、
  /// [questionedAt] に DailyQuiz の出題日を指定すること。
  ///
  /// Copied from [HitterQuizNotifier].
  const HitterQuizNotifierFamily();

  /// [HitterQuiz] を保持する。
  ///
  /// [quizType] に [QuizType.daily] を指定する場合、
  /// [questionedAt] に DailyQuiz の出題日を指定すること。
  ///
  /// Copied from [HitterQuizNotifier].
  HitterQuizNotifierProvider call(
    QuizType quizType, {
    required DateTime? questionedAt,
  }) {
    return HitterQuizNotifierProvider(
      quizType,
      questionedAt: questionedAt,
    );
  }

  @override
  HitterQuizNotifierProvider getProviderOverride(
    covariant HitterQuizNotifierProvider provider,
  ) {
    return call(
      provider.quizType,
      questionedAt: provider.questionedAt,
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
  String? get name => r'hitterQuizNotifierProvider';
}

/// [HitterQuiz] を保持する。
///
/// [quizType] に [QuizType.daily] を指定する場合、
/// [questionedAt] に DailyQuiz の出題日を指定すること。
///
/// Copied from [HitterQuizNotifier].
class HitterQuizNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    HitterQuizNotifier, HitterQuiz> {
  /// [HitterQuiz] を保持する。
  ///
  /// [quizType] に [QuizType.daily] を指定する場合、
  /// [questionedAt] に DailyQuiz の出題日を指定すること。
  ///
  /// Copied from [HitterQuizNotifier].
  HitterQuizNotifierProvider(
    QuizType quizType, {
    required DateTime? questionedAt,
  }) : this._internal(
          () => HitterQuizNotifier()
            ..quizType = quizType
            ..questionedAt = questionedAt,
          from: hitterQuizNotifierProvider,
          name: r'hitterQuizNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hitterQuizNotifierHash,
          dependencies: HitterQuizNotifierFamily._dependencies,
          allTransitiveDependencies:
              HitterQuizNotifierFamily._allTransitiveDependencies,
          quizType: quizType,
          questionedAt: questionedAt,
        );

  HitterQuizNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.quizType,
    required this.questionedAt,
  }) : super.internal();

  final QuizType quizType;
  final DateTime? questionedAt;

  @override
  FutureOr<HitterQuiz> runNotifierBuild(
    covariant HitterQuizNotifier notifier,
  ) {
    return notifier.build(
      quizType,
      questionedAt: questionedAt,
    );
  }

  @override
  Override overrideWith(HitterQuizNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: HitterQuizNotifierProvider._internal(
        () => create()
          ..quizType = quizType
          ..questionedAt = questionedAt,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        quizType: quizType,
        questionedAt: questionedAt,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<HitterQuizNotifier, HitterQuiz>
      createElement() {
    return _HitterQuizNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HitterQuizNotifierProvider &&
        other.quizType == quizType &&
        other.questionedAt == questionedAt;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quizType.hashCode);
    hash = _SystemHash.combine(hash, questionedAt.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HitterQuizNotifierRef on AutoDisposeAsyncNotifierProviderRef<HitterQuiz> {
  /// The parameter `quizType` of this provider.
  QuizType get quizType;

  /// The parameter `questionedAt` of this provider.
  DateTime? get questionedAt;
}

class _HitterQuizNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<HitterQuizNotifier,
        HitterQuiz> with HitterQuizNotifierRef {
  _HitterQuizNotifierProviderElement(super.provider);

  @override
  QuizType get quizType => (origin as HitterQuizNotifierProvider).quizType;
  @override
  DateTime? get questionedAt =>
      (origin as HitterQuizNotifierProvider).questionedAt;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
