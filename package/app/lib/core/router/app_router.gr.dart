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
    GalleryDetailDailyQuizRoute.name: (routeData) {
      final args = routeData.argsAs<GalleryDetailDailyQuizRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: GalleryDetailDailyQuizPage(
          key: args.key,
          hitterQuizResult: args.hitterQuizResult,
        ),
      );
    },
    GalleryDetailNormalQuizRoute.name: (routeData) {
      final args = routeData.argsAs<GalleryDetailNormalQuizRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: GalleryDetailNormalQuizPage(
          key: args.key,
          quizResult: args.quizResult,
        ),
      );
    },
    GalleryListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GalleryListPage(),
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
    QuizSettingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const QuizSettingPage(),
      );
    },
    ResultDailyQuizRoute.name: (routeData) {
      final args = routeData.argsAs<ResultDailyQuizRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ResultDailyQuizPage(
          key: args.key,
          questionedAt: args.questionedAt,
        ),
      );
    },
    ResultNormalQuizRoute.name: (routeData) {
      final args = routeData.argsAs<ResultNormalQuizRouteArgs>(
          orElse: () => const ResultNormalQuizRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ResultNormalQuizPage(key: args.key),
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
/// [GalleryDetailDailyQuizPage]
class GalleryDetailDailyQuizRoute
    extends PageRouteInfo<GalleryDetailDailyQuizRouteArgs> {
  GalleryDetailDailyQuizRoute({
    Key? key,
    required HitterQuizResult hitterQuizResult,
    List<PageRouteInfo>? children,
  }) : super(
          GalleryDetailDailyQuizRoute.name,
          args: GalleryDetailDailyQuizRouteArgs(
            key: key,
            hitterQuizResult: hitterQuizResult,
          ),
          initialChildren: children,
        );

  static const String name = 'GalleryDetailDailyQuizRoute';

  static const PageInfo<GalleryDetailDailyQuizRouteArgs> page =
      PageInfo<GalleryDetailDailyQuizRouteArgs>(name);
}

class GalleryDetailDailyQuizRouteArgs {
  const GalleryDetailDailyQuizRouteArgs({
    this.key,
    required this.hitterQuizResult,
  });

  final Key? key;

  final HitterQuizResult hitterQuizResult;

  @override
  String toString() {
    return 'GalleryDetailDailyQuizRouteArgs{key: $key, hitterQuizResult: $hitterQuizResult}';
  }
}

/// generated route for
/// [GalleryDetailNormalQuizPage]
class GalleryDetailNormalQuizRoute
    extends PageRouteInfo<GalleryDetailNormalQuizRouteArgs> {
  GalleryDetailNormalQuizRoute({
    Key? key,
    required HitterQuizResult quizResult,
    List<PageRouteInfo>? children,
  }) : super(
          GalleryDetailNormalQuizRoute.name,
          args: GalleryDetailNormalQuizRouteArgs(
            key: key,
            quizResult: quizResult,
          ),
          initialChildren: children,
        );

  static const String name = 'GalleryDetailNormalQuizRoute';

  static const PageInfo<GalleryDetailNormalQuizRouteArgs> page =
      PageInfo<GalleryDetailNormalQuizRouteArgs>(name);
}

class GalleryDetailNormalQuizRouteArgs {
  const GalleryDetailNormalQuizRouteArgs({
    this.key,
    required this.quizResult,
  });

  final Key? key;

  final HitterQuizResult quizResult;

  @override
  String toString() {
    return 'GalleryDetailNormalQuizRouteArgs{key: $key, quizResult: $quizResult}';
  }
}

/// generated route for
/// [GalleryListPage]
class GalleryListRoute extends PageRouteInfo<void> {
  const GalleryListRoute({List<PageRouteInfo>? children})
      : super(
          GalleryListRoute.name,
          initialChildren: children,
        );

  static const String name = 'GalleryListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [QuizSettingPage]
class QuizSettingRoute extends PageRouteInfo<void> {
  const QuizSettingRoute({List<PageRouteInfo>? children})
      : super(
          QuizSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuizSettingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ResultDailyQuizPage]
class ResultDailyQuizRoute extends PageRouteInfo<ResultDailyQuizRouteArgs> {
  ResultDailyQuizRoute({
    Key? key,
    required DateTime questionedAt,
    List<PageRouteInfo>? children,
  }) : super(
          ResultDailyQuizRoute.name,
          args: ResultDailyQuizRouteArgs(
            key: key,
            questionedAt: questionedAt,
          ),
          initialChildren: children,
        );

  static const String name = 'ResultDailyQuizRoute';

  static const PageInfo<ResultDailyQuizRouteArgs> page =
      PageInfo<ResultDailyQuizRouteArgs>(name);
}

class ResultDailyQuizRouteArgs {
  const ResultDailyQuizRouteArgs({
    this.key,
    required this.questionedAt,
  });

  final Key? key;

  final DateTime questionedAt;

  @override
  String toString() {
    return 'ResultDailyQuizRouteArgs{key: $key, questionedAt: $questionedAt}';
  }
}

/// generated route for
/// [ResultNormalQuizPage]
class ResultNormalQuizRoute extends PageRouteInfo<ResultNormalQuizRouteArgs> {
  ResultNormalQuizRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ResultNormalQuizRoute.name,
          args: ResultNormalQuizRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ResultNormalQuizRoute';

  static const PageInfo<ResultNormalQuizRouteArgs> page =
      PageInfo<ResultNormalQuizRouteArgs>(name);
}

class ResultNormalQuizRouteArgs {
  const ResultNormalQuizRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ResultNormalQuizRouteArgs{key: $key}';
  }
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
