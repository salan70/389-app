// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$targetSeasonHash() => r'f3b18745366e6ac13106b1fe8aad4434b6fb48b0';

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

/// See also [targetSeason].
@ProviderFor(targetSeason)
const targetSeasonProvider = TargetSeasonFamily();

/// See also [targetSeason].
class TargetSeasonFamily extends Family<AsyncValue<SeasonType>> {
  /// See also [targetSeason].
  const TargetSeasonFamily();

  /// See also [targetSeason].
  TargetSeasonProvider call(
    DateTime baseDate,
  ) {
    return TargetSeasonProvider(
      baseDate,
    );
  }

  @override
  TargetSeasonProvider getProviderOverride(
    covariant TargetSeasonProvider provider,
  ) {
    return call(
      provider.baseDate,
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
  String? get name => r'targetSeasonProvider';
}

/// See also [targetSeason].
class TargetSeasonProvider extends AutoDisposeFutureProvider<SeasonType> {
  /// See also [targetSeason].
  TargetSeasonProvider(
    DateTime baseDate,
  ) : this._internal(
          (ref) => targetSeason(
            ref as TargetSeasonRef,
            baseDate,
          ),
          from: targetSeasonProvider,
          name: r'targetSeasonProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$targetSeasonHash,
          dependencies: TargetSeasonFamily._dependencies,
          allTransitiveDependencies:
              TargetSeasonFamily._allTransitiveDependencies,
          baseDate: baseDate,
        );

  TargetSeasonProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.baseDate,
  }) : super.internal();

  final DateTime baseDate;

  @override
  Override overrideWith(
    FutureOr<SeasonType> Function(TargetSeasonRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TargetSeasonProvider._internal(
        (ref) => create(ref as TargetSeasonRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        baseDate: baseDate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SeasonType> createElement() {
    return _TargetSeasonProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TargetSeasonProvider && other.baseDate == baseDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, baseDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TargetSeasonRef on AutoDisposeFutureProviderRef<SeasonType> {
  /// The parameter `baseDate` of this provider.
  DateTime get baseDate;
}

class _TargetSeasonProviderElement
    extends AutoDisposeFutureProviderElement<SeasonType> with TargetSeasonRef {
  _TargetSeasonProviderElement(super.provider);

  @override
  DateTime get baseDate => (origin as TargetSeasonProvider).baseDate;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
