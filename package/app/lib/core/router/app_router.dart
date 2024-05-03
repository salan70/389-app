import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../ui/page/gallery_list_page.dart';
import '../../ui/page/play_daily_quiz_page.dart';
import '../../ui/page/play_normal_quiz_page.dart';
import '../../ui/page/quiz_history_daily_page.dart';
import '../../ui/page/quiz_history_normal_page.dart';
import '../../ui/page/quiz_setting_page.dart';
import '../../ui/page/result_daily_quiz_page.dart';
import '../../ui/page/result_normal_quiz_page.dart';
import '../../ui/page/top_page.dart';

part 'app_router.g.dart';
part 'app_router.gr.dart';

@riverpod
Raw<AppRouter> appRouter(AppRouterRef ref) => AppRouter();

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: TopRoute.page, initial: true),
        AutoRoute(page: QuizSettingRoute.page),
        AutoRoute(page: GalleryListRoute.page),
        AutoRoute(page: QuizHistoryDailyRoute.page),
        AutoRoute(page: QuizHistoryNormalRoute.page),
        AutoRoute(page: ResultNormalQuizRoute.page),
        AutoRoute(page: ResultDailyQuizRoute.page),
        AutoRoute(page: PlayNormalQuizRoute.page),
        AutoRoute(page: PlayDailyQuizRoute.page),
      ];
}
