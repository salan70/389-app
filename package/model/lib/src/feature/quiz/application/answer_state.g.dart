// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allHitterListHash() => r'ad4f881b0e649af254365072344d103c5a66ead4';

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

/// 全野手のIDと名前のリストを返すプロバイダー
///
/// Copied from [allHitterList].
@ProviderFor(allHitterList)
const allHitterListProvider = AllHitterListFamily();

/// 全野手のIDと名前のリストを返すプロバイダー
///
/// Copied from [allHitterList].
class AllHitterListFamily extends Family<AsyncValue<List<Hitter>>> {
  /// 全野手のIDと名前のリストを返すプロバイダー
  ///
  /// Copied from [allHitterList].
  const AllHitterListFamily();

  /// 全野手のIDと名前のリストを返すプロバイダー
  ///
  /// Copied from [allHitterList].
  AllHitterListProvider call(
    SeasonType seasonType,
  ) {
    return AllHitterListProvider(
      seasonType,
    );
  }

  @override
  AllHitterListProvider getProviderOverride(
    covariant AllHitterListProvider provider,
  ) {
    return call(
      provider.seasonType,
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
  String? get name => r'allHitterListProvider';
}

/// 全野手のIDと名前のリストを返すプロバイダー
///
/// Copied from [allHitterList].
class AllHitterListProvider extends AutoDisposeFutureProvider<List<Hitter>> {
  /// 全野手のIDと名前のリストを返すプロバイダー
  ///
  /// Copied from [allHitterList].
  AllHitterListProvider(
    SeasonType seasonType,
  ) : this._internal(
          (ref) => allHitterList(
            ref as AllHitterListRef,
            seasonType,
          ),
          from: allHitterListProvider,
          name: r'allHitterListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$allHitterListHash,
          dependencies: AllHitterListFamily._dependencies,
          allTransitiveDependencies:
              AllHitterListFamily._allTransitiveDependencies,
          seasonType: seasonType,
        );

  AllHitterListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.seasonType,
  }) : super.internal();

  final SeasonType seasonType;

  @override
  Override overrideWith(
    FutureOr<List<Hitter>> Function(AllHitterListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AllHitterListProvider._internal(
        (ref) => create(ref as AllHitterListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        seasonType: seasonType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Hitter>> createElement() {
    return _AllHitterListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllHitterListProvider && other.seasonType == seasonType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, seasonType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AllHitterListRef on AutoDisposeFutureProviderRef<List<Hitter>> {
  /// The parameter `seasonType` of this provider.
  SeasonType get seasonType;
}

class _AllHitterListProviderElement
    extends AutoDisposeFutureProviderElement<List<Hitter>>
    with AllHitterListRef {
  _AllHitterListProviderElement(super.provider);

  @override
  SeasonType get seasonType => (origin as AllHitterListProvider).seasonType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
