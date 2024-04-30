// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DailyQuizGalleryDetailRoute.name: (routeData) {
      final args = routeData.argsAs<DailyQuizGalleryDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DailyQuizGalleryDetailPage(
          key: args.key,
          hitterQuizResult: args.hitterQuizResult,
        ),
      );
    },
    DailyQuizGalleryListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DailyQuizGalleryListPage(),
      );
    },
    DailyQuizResultRoute.name: (routeData) {
      final args = routeData.argsAs<DailyQuizResultRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DailyQuizResultPage(
          key: args.key,
          questionedAt: args.questionedAt,
        ),
      );
    },
    NormalQuizGalleryDetailRoute.name: (routeData) {
      final args = routeData.argsAs<NormalQuizGalleryDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NormalQuizGalleryDetailPage(
          key: args.key,
          quizResult: args.quizResult,
        ),
      );
    },
    NormalQuizGalleryListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NormalQuizGalleryListPage(),
      );
    },
    NormalQuizResultRoute.name: (routeData) {
      final args = routeData.argsAs<NormalQuizResultRouteArgs>(
          orElse: () => const NormalQuizResultRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NormalQuizResultPage(key: args.key),
      );
    },
    PlayDailyQuizRoute.name: (routeData) {
      final args = routeData.argsAs<PlayDailyQuizRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PlayDailyQuizPage(
          key: args.key,
          questionedAt: args.questionedAt,
        ),
      );
    },
    PlayNormalQuizRoute.name: (routeData) {
      final args = routeData.argsAs<PlayNormalQuizRouteArgs>(
          orElse: () => const PlayNormalQuizRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PlayNormalQuizPage(key: args.key),
      );
    },
    PrepareQuizRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PrepareQuizPage(),
      );
    },
    TopRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TopPage(),
      );
    },
  };
}

/// generated route for
/// [DailyQuizGalleryDetailPage]
class DailyQuizGalleryDetailRoute
    extends PageRouteInfo<DailyQuizGalleryDetailRouteArgs> {
  DailyQuizGalleryDetailRoute({
    Key? key,
    required HitterQuizResult hitterQuizResult,
    List<PageRouteInfo>? children,
  }) : super(
          DailyQuizGalleryDetailRoute.name,
          args: DailyQuizGalleryDetailRouteArgs(
            key: key,
            hitterQuizResult: hitterQuizResult,
          ),
          initialChildren: children,
        );

  static const String name = 'DailyQuizGalleryDetailRoute';

  static const PageInfo<DailyQuizGalleryDetailRouteArgs> page =
      PageInfo<DailyQuizGalleryDetailRouteArgs>(name);
}

class DailyQuizGalleryDetailRouteArgs {
  const DailyQuizGalleryDetailRouteArgs({
    this.key,
    required this.hitterQuizResult,
  });

  final Key? key;

  final HitterQuizResult hitterQuizResult;

  @override
  String toString() {
    return 'DailyQuizGalleryDetailRouteArgs{key: $key, hitterQuizResult: $hitterQuizResult}';
  }
}

/// generated route for
/// [DailyQuizGalleryListPage]
class DailyQuizGalleryListRoute extends PageRouteInfo<void> {
  const DailyQuizGalleryListRoute({List<PageRouteInfo>? children})
      : super(
          DailyQuizGalleryListRoute.name,
          initialChildren: children,
        );

  static const String name = 'DailyQuizGalleryListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DailyQuizResultPage]
class DailyQuizResultRoute extends PageRouteInfo<DailyQuizResultRouteArgs> {
  DailyQuizResultRoute({
    Key? key,
    required DateTime questionedAt,
    List<PageRouteInfo>? children,
  }) : super(
          DailyQuizResultRoute.name,
          args: DailyQuizResultRouteArgs(
            key: key,
            questionedAt: questionedAt,
          ),
          initialChildren: children,
        );

  static const String name = 'DailyQuizResultRoute';

  static const PageInfo<DailyQuizResultRouteArgs> page =
      PageInfo<DailyQuizResultRouteArgs>(name);
}

class DailyQuizResultRouteArgs {
  const DailyQuizResultRouteArgs({
    this.key,
    required this.questionedAt,
  });

  final Key? key;

  final DateTime questionedAt;

  @override
  String toString() {
    return 'DailyQuizResultRouteArgs{key: $key, questionedAt: $questionedAt}';
  }
}

/// generated route for
/// [NormalQuizGalleryDetailPage]
class NormalQuizGalleryDetailRoute
    extends PageRouteInfo<NormalQuizGalleryDetailRouteArgs> {
  NormalQuizGalleryDetailRoute({
    Key? key,
    required HitterQuizResult quizResult,
    List<PageRouteInfo>? children,
  }) : super(
          NormalQuizGalleryDetailRoute.name,
          args: NormalQuizGalleryDetailRouteArgs(
            key: key,
            quizResult: quizResult,
          ),
          initialChildren: children,
        );

  static const String name = 'NormalQuizGalleryDetailRoute';

  static const PageInfo<NormalQuizGalleryDetailRouteArgs> page =
      PageInfo<NormalQuizGalleryDetailRouteArgs>(name);
}

class NormalQuizGalleryDetailRouteArgs {
  const NormalQuizGalleryDetailRouteArgs({
    this.key,
    required this.quizResult,
  });

  final Key? key;

  final HitterQuizResult quizResult;

  @override
  String toString() {
    return 'NormalQuizGalleryDetailRouteArgs{key: $key, quizResult: $quizResult}';
  }
}

/// generated route for
/// [NormalQuizGalleryListPage]
class NormalQuizGalleryListRoute extends PageRouteInfo<void> {
  const NormalQuizGalleryListRoute({List<PageRouteInfo>? children})
      : super(
          NormalQuizGalleryListRoute.name,
          initialChildren: children,
        );

  static const String name = 'NormalQuizGalleryListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NormalQuizResultPage]
class NormalQuizResultRoute extends PageRouteInfo<NormalQuizResultRouteArgs> {
  NormalQuizResultRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          NormalQuizResultRoute.name,
          args: NormalQuizResultRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'NormalQuizResultRoute';

  static const PageInfo<NormalQuizResultRouteArgs> page =
      PageInfo<NormalQuizResultRouteArgs>(name);
}

class NormalQuizResultRouteArgs {
  const NormalQuizResultRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'NormalQuizResultRouteArgs{key: $key}';
  }
}

/// generated route for
/// [PlayDailyQuizPage]
class PlayDailyQuizRoute extends PageRouteInfo<PlayDailyQuizRouteArgs> {
  PlayDailyQuizRoute({
    Key? key,
    required DateTime questionedAt,
    List<PageRouteInfo>? children,
  }) : super(
          PlayDailyQuizRoute.name,
          args: PlayDailyQuizRouteArgs(
            key: key,
            questionedAt: questionedAt,
          ),
          initialChildren: children,
        );

  static const String name = 'PlayDailyQuizRoute';

  static const PageInfo<PlayDailyQuizRouteArgs> page =
      PageInfo<PlayDailyQuizRouteArgs>(name);
}

class PlayDailyQuizRouteArgs {
  const PlayDailyQuizRouteArgs({
    this.key,
    required this.questionedAt,
  });

  final Key? key;

  final DateTime questionedAt;

  @override
  String toString() {
    return 'PlayDailyQuizRouteArgs{key: $key, questionedAt: $questionedAt}';
  }
}

/// generated route for
/// [PlayNormalQuizPage]
class PlayNormalQuizRoute extends PageRouteInfo<PlayNormalQuizRouteArgs> {
  PlayNormalQuizRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          PlayNormalQuizRoute.name,
          args: PlayNormalQuizRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PlayNormalQuizRoute';

  static const PageInfo<PlayNormalQuizRouteArgs> page =
      PageInfo<PlayNormalQuizRouteArgs>(name);
}

class PlayNormalQuizRouteArgs {
  const PlayNormalQuizRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'PlayNormalQuizRouteArgs{key: $key}';
  }
}

/// generated route for
/// [PrepareQuizPage]
class PrepareQuizRoute extends PageRouteInfo<void> {
  const PrepareQuizRoute({List<PageRouteInfo>? children})
      : super(
          PrepareQuizRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrepareQuizRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TopPage]
class TopRoute extends PageRouteInfo<void> {
  const TopRoute({List<PageRouteInfo>? children})
      : super(
          TopRoute.name,
          initialChildren: children,
        );

  static const String name = 'TopRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
