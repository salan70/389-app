import 'package:flutter/material.dart';

import '../../../../common_widget/back_to_top_button.dart';
import '../../../../common_widget/my_button.dart';
import '../../../../util/constant/colors_constant.dart';
import '../../../admob/presentation/banner_ad_widget.dart';
import 'daily_quiz_gallery_list_page.dart';
import 'normal_quiz_gallery_list_page.dart';

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
