import 'package:flutter/material.dart';

import '../../page/daily_quiz_gallery_list_page.dart';
import '../../page/normal_quiz_gallery_list_page.dart';
import '../../util/colors_constant.dart';
import '../ad/banner_ad_widget.dart';
import '../common/button/back_to_top_button.dart';
import '../common/button/my_button.dart';

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
                        NormalQuizGalleryListPage(),
                        DailyQuizGalleryListPage(),
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
