import 'package:flutter/material.dart';

import '../../../core/common_widget/button/back_to_top_button.dart';
import '../../../core/common_widget/button/my_button.dart';
import '../../../core/util/colors_constant.dart';
import '../../page/gallery_list_daily_quiz_page.dart';
import '../../page/gallery_list_normal_quiz_page.dart';
import '../ad/banner_ad_widget.dart';

class BaseGalleryListPage extends StatelessWidget {
  const BaseGalleryListPage({super.key});

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
                        GalleryListNormalQuizPage(),
                        GalleryListDailyQuizPage(),
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
