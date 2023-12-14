// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hitter_quiz_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hitterQuizNotifierHash() =>
    r'd2f15c5acf41c8967e1a767a3cd43d4f1f82e59a';

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

  FutureOr<HitterQuiz> build(
    QuizType quizType,
  );
}

/// See also [HitterQuizNotifier].
@ProviderFor(HitterQuizNotifier)
const hitterQuizNotifierProvider = HitterQuizNotifierFamily();

/// See also [HitterQuizNotifier].
class HitterQuizNotifierFamily extends Family<AsyncValue<HitterQuiz>> {
  /// See also [HitterQuizNotifier].
  const HitterQuizNotifierFamily();

  /// See also [HitterQuizNotifier].
  HitterQuizNotifierProvider call(
    QuizType quizType,
  ) {
    return HitterQuizNotifierProvider(
      quizType,
    );
  }

  @override
  HitterQuizNotifierProvider getProviderOverride(
    covariant HitterQuizNotifierProvider provider,
  ) {
    return call(
      provider.quizType,
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

/// See also [HitterQuizNotifier].
class HitterQuizNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    HitterQuizNotifier, HitterQuiz> {
  /// See also [HitterQuizNotifier].
  HitterQuizNotifierProvider(
    QuizType quizType,
  ) : this._internal(
          () => HitterQuizNotifier()..quizType = quizType,
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
        );

  HitterQuizNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.quizType,
  }) : super.internal();

  final QuizType quizType;

  @override
  FutureOr<HitterQuiz> runNotifierBuild(
    covariant HitterQuizNotifier notifier,
  ) {
    return notifier.build(
      quizType,
    );
  }

  @override
  Override overrideWith(HitterQuizNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: HitterQuizNotifierProvider._internal(
        () => create()..quizType = quizType,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        quizType: quizType,
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
    return other is HitterQuizNotifierProvider && other.quizType == quizType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quizType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HitterQuizNotifierRef on AutoDisposeAsyncNotifierProviderRef<HitterQuiz> {
  /// The parameter `quizType` of this provider.
  QuizType get quizType;
}

class _HitterQuizNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<HitterQuizNotifier,
        HitterQuiz> with HitterQuizNotifierRef {
  _HitterQuizNotifierProviderElement(super.provider);

  @override
  QuizType get quizType => (origin as HitterQuizNotifierProvider).quizType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
