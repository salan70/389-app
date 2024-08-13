// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_daily_quiz_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playDailyQuizPageControllerHash() =>
    r'0ea2a6b01632486f7ca303dda22453e5291e6893';

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

abstract class _$PlayDailyQuizPageController
    extends BuildlessAutoDisposeAsyncNotifier<PlayDailyQuizPageState> {
  late final DateTime questionedAt;

  FutureOr<PlayDailyQuizPageState> build(
    DateTime questionedAt,
  );
}

/// See also [PlayDailyQuizPageController].
@ProviderFor(PlayDailyQuizPageController)
const playDailyQuizPageControllerProvider = PlayDailyQuizPageControllerFamily();

/// See also [PlayDailyQuizPageController].
class PlayDailyQuizPageControllerFamily
    extends Family<AsyncValue<PlayDailyQuizPageState>> {
  /// See also [PlayDailyQuizPageController].
  const PlayDailyQuizPageControllerFamily();

  /// See also [PlayDailyQuizPageController].
  PlayDailyQuizPageControllerProvider call(
    DateTime questionedAt,
  ) {
    return PlayDailyQuizPageControllerProvider(
      questionedAt,
    );
  }

  @override
  PlayDailyQuizPageControllerProvider getProviderOverride(
    covariant PlayDailyQuizPageControllerProvider provider,
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
  String? get name => r'playDailyQuizPageControllerProvider';
}

/// See also [PlayDailyQuizPageController].
class PlayDailyQuizPageControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PlayDailyQuizPageController,
        PlayDailyQuizPageState> {
  /// See also [PlayDailyQuizPageController].
  PlayDailyQuizPageControllerProvider(
    DateTime questionedAt,
  ) : this._internal(
          () => PlayDailyQuizPageController()..questionedAt = questionedAt,
          from: playDailyQuizPageControllerProvider,
          name: r'playDailyQuizPageControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playDailyQuizPageControllerHash,
          dependencies: PlayDailyQuizPageControllerFamily._dependencies,
          allTransitiveDependencies:
              PlayDailyQuizPageControllerFamily._allTransitiveDependencies,
          questionedAt: questionedAt,
        );

  PlayDailyQuizPageControllerProvider._internal(
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
  FutureOr<PlayDailyQuizPageState> runNotifierBuild(
    covariant PlayDailyQuizPageController notifier,
  ) {
    return notifier.build(
      questionedAt,
    );
  }

  @override
  Override overrideWith(PlayDailyQuizPageController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlayDailyQuizPageControllerProvider._internal(
        () => create()..questionedAt = questionedAt,
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
  AutoDisposeAsyncNotifierProviderElement<PlayDailyQuizPageController,
      PlayDailyQuizPageState> createElement() {
    return _PlayDailyQuizPageControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlayDailyQuizPageControllerProvider &&
        other.questionedAt == questionedAt;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, questionedAt.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlayDailyQuizPageControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PlayDailyQuizPageState> {
  /// The parameter `questionedAt` of this provider.
  DateTime get questionedAt;
}

class _PlayDailyQuizPageControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PlayDailyQuizPageController,
        PlayDailyQuizPageState> with PlayDailyQuizPageControllerRef {
  _PlayDailyQuizPageControllerProviderElement(super.provider);

  @override
  DateTime get questionedAt =>
      (origin as PlayDailyQuizPageControllerProvider).questionedAt;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
