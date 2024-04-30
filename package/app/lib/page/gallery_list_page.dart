import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/common_widget/button/my_button.dart';
import '../../core/util/colors_constant.dart';
import '../core/common_widget/navigation_button/back_to_top_button.dart';
import '../feature/ad/banner_ad_widget.dart';
import '../feature/gallery/daily_quiz_gallery_list.dart';
import '../feature/gallery/normal_quiz_gallery_list.dart';

@RoutePage()
class GalleryListPage extends StatelessWidget {
  const GalleryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelStyle: Theme.of(context).textTheme.titleLarge,
                    labelColor: primaryColor,
                    indicatorColor: primaryColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: const <Widget>[
                      Tab(text: 'ノーマルクイズ'),
                      Tab(text: '今日の１問'),
                    ],
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        NormalQuizGalleryList(),
                        DailyQuizGalleryList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 120,
                    child: BackToTopButton(buttonType: ButtonType.main),
                  ),
                  SizedBox(height: 16),
                  BannerAdWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
