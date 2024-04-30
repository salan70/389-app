import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../page/daily_quiz_gallery_detail_page.dart';
import '../../page/daily_quiz_gallery_list_page.dart';
import '../../page/daily_quiz_result_page.dart';
import '../../page/normal_quiz_gallery_detail_page.dart';
import '../../page/normal_quiz_gallery_list_page.dart';
import '../../page/normal_quiz_result_page.dart';
import '../../page/play_daily_quiz_page.dart';
import '../../page/play_normal_quiz_page.dart';
import '../../page/prepare_quiz_page.dart';
import '../../page/top_page.dart';

part 'app_router.g.dart';
part 'app_router.gr.dart';

@riverpod
Raw<AppRouter> appRouter(AppRouterRef ref) => AppRouter();

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: TopRoute.page, initial: true),
        AutoRoute(page: PrepareQuizRoute.page),
        AutoRoute(page: NormalQuizGalleryListRoute.page),
        AutoRoute(page: NormalQuizResultRoute.page),
        AutoRoute(page: DailyQuizGalleryListRoute.page),
        AutoRoute(page: DailyQuizResultRoute.page),
        AutoRoute(page: NormalQuizGalleryDetailRoute.page),
        AutoRoute(page: DailyQuizGalleryDetailRoute.page),
        AutoRoute(page: PlayNormalQuizRoute.page),
        AutoRoute(page: PlayDailyQuizRoute.page),
      ];
}
