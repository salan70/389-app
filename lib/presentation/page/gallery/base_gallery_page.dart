import 'package:flutter/material.dart';

import '../../../util/constant/colors_constant.dart';
import '../../component/banner_ad_widget.dart';
import '../../component/to_top_button.dart';

class BaseGalleryPage extends StatelessWidget {
  const BaseGalleryPage({super.key});

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
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Container(),
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  ToTopButton(),
                  SizedBox(height: 8),
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
