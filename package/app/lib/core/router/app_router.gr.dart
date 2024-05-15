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
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PlayNormalQuizPage(),
      );
    },
    QuizHistoryDailyRoute.name: (routeData) {
      final args = routeData.argsAs<QuizHistoryDailyRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: QuizHistoryDailyPage(
          key: args.key,
          hitterQuizResult: args.hitterQuizResult,
        ),
      );
    },
    QuizHistoryNormalRoute.name: (routeData) {
      final args = routeData.argsAs<QuizHistoryNormalRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: QuizHistoryNormalPage(
          key: args.key,
          quizResult: args.quizResult,
        ),
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
          quizState: args.quizState,
        ),
      );
    },
    ResultNormalQuizRoute.name: (routeData) {
      final args = routeData.argsAs<ResultNormalQuizRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ResultNormalQuizPage(
          key: args.key,
          quizState: args.quizState,
        ),
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
class PlayNormalQuizRoute extends PageRouteInfo<void> {
  const PlayNormalQuizRoute({List<PageRouteInfo>? children})
      : super(
          PlayNormalQuizRoute.name,
          initialChildren: children,
        );

  static const String name = 'PlayNormalQuizRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [QuizHistoryDailyPage]
class QuizHistoryDailyRoute extends PageRouteInfo<QuizHistoryDailyRouteArgs> {
  QuizHistoryDailyRoute({
    Key? key,
    required HitterQuizResult hitterQuizResult,
    List<PageRouteInfo>? children,
  }) : super(
          QuizHistoryDailyRoute.name,
          args: QuizHistoryDailyRouteArgs(
            key: key,
            hitterQuizResult: hitterQuizResult,
          ),
          initialChildren: children,
        );

  static const String name = 'QuizHistoryDailyRoute';

  static const PageInfo<QuizHistoryDailyRouteArgs> page =
      PageInfo<QuizHistoryDailyRouteArgs>(name);
}

class QuizHistoryDailyRouteArgs {
  const QuizHistoryDailyRouteArgs({
    this.key,
    required this.hitterQuizResult,
  });

  final Key? key;

  final HitterQuizResult hitterQuizResult;

  @override
  String toString() {
    return 'QuizHistoryDailyRouteArgs{key: $key, hitterQuizResult: $hitterQuizResult}';
  }
}

/// generated route for
/// [QuizHistoryNormalPage]
class QuizHistoryNormalRoute extends PageRouteInfo<QuizHistoryNormalRouteArgs> {
  QuizHistoryNormalRoute({
    Key? key,
    required HitterQuizResult quizResult,
    List<PageRouteInfo>? children,
  }) : super(
          QuizHistoryNormalRoute.name,
          args: QuizHistoryNormalRouteArgs(
            key: key,
            quizResult: quizResult,
          ),
          initialChildren: children,
        );

  static const String name = 'QuizHistoryNormalRoute';

  static const PageInfo<QuizHistoryNormalRouteArgs> page =
      PageInfo<QuizHistoryNormalRouteArgs>(name);
}

class QuizHistoryNormalRouteArgs {
  const QuizHistoryNormalRouteArgs({
    this.key,
    required this.quizResult,
  });

  final Key? key;

  final HitterQuizResult quizResult;

  @override
  String toString() {
    return 'QuizHistoryNormalRouteArgs{key: $key, quizResult: $quizResult}';
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
    required InputQuizState quizState,
    List<PageRouteInfo>? children,
  }) : super(
          ResultDailyQuizRoute.name,
          args: ResultDailyQuizRouteArgs(
            key: key,
            quizState: quizState,
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
    required this.quizState,
  });

  final Key? key;

  final InputQuizState quizState;

  @override
  String toString() {
    return 'ResultDailyQuizRouteArgs{key: $key, quizState: $quizState}';
  }
}

/// generated route for
/// [ResultNormalQuizPage]
class ResultNormalQuizRoute extends PageRouteInfo<ResultNormalQuizRouteArgs> {
  ResultNormalQuizRoute({
    Key? key,
    required InputQuizState quizState,
    List<PageRouteInfo>? children,
  }) : super(
          ResultNormalQuizRoute.name,
          args: ResultNormalQuizRouteArgs(
            key: key,
            quizState: quizState,
          ),
          initialChildren: children,
        );

  static const String name = 'ResultNormalQuizRoute';

  static const PageInfo<ResultNormalQuizRouteArgs> page =
      PageInfo<ResultNormalQuizRouteArgs>(name);
}

class ResultNormalQuizRouteArgs {
  const ResultNormalQuizRouteArgs({
    this.key,
    required this.quizState,
  });

  final Key? key;

  final InputQuizState quizState;

  @override
  String toString() {
    return 'ResultNormalQuizRouteArgs{key: $key, quizState: $quizState}';
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
