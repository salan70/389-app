import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../page/gallery_detail_daily_quiz_page.dart';
import '../../page/gallery_detail_normal_quiz_page.dart';
import '../../page/gallery_list_daily_quiz_page.dart';
import '../../page/gallery_list_normal_quiz_page.dart';
import '../../page/play_daily_quiz_page.dart';
import '../../page/play_normal_quiz_page.dart';
import '../../page/quiz_setting_page.dart';
import '../../page/result_daily_quiz_page.dart';
import '../../page/result_normal_quiz_page.dart';
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
        AutoRoute(page: QuizSettingRoute.page),
        AutoRoute(page: GalleryListNormalQuizRoute.page),
        AutoRoute(page: GalleryListDailyQuizRoute.page),
        AutoRoute(page: GalleryDetailNormalQuizRoute.page),
        AutoRoute(page: GalleryDetailDailyQuizRoute.page),
        AutoRoute(page: ResultNormalQuizRoute.page),
        AutoRoute(page: ResultDailyQuizRoute.page),
        AutoRoute(page: PlayNormalQuizRoute.page),
        AutoRoute(page: PlayDailyQuizRoute.page),
      ];
}
