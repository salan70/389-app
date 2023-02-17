import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../util/constant/text_in_app.dart';
import '../../component/banner_ad_widget.dart';
import '../../component/play_quiz/answer_widget.dart';
import '../../component/play_quiz/quiz_event_buttons.dart';
import '../../component/play_quiz/retire_button.dart';
import '../../component/quiz_widget.dart';
import 'component/life_widget.dart';

class PlayDailyQuizPage extends StatelessWidget {
  const PlayDailyQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            behavior: HitTestBehavior.opaque,
            child: ListView(
              children: const [
                //TODO: ライフ機能
                //TODO: Androidのバックキー制御
                //TODO: Firestoreに保存したデータを取得し、デイリークイズを作成する
                //TODO: サーバー時間から、デイリークイズに使用するデータを取得する
                //TODO: プレイ状況/結果をFirestoreに保存
                //TODO: 共通化したWidgetで、文字列などの切り分けが必要ないか確認
                //TODO: デイリークイズ用の結果画面を用意
                //TODO: デイリークイズ用のシェア機能を用意（文言変えるだけっぽそう）
                BannerAdWidget(),
                SizedBox(height: 16),
                LifeWidget(),
                SizedBox(height: 16),
                QuizWidget(willUpdate: true),
                SizedBox(height: 16),
                QuizEventButtons(),
                SizedBox(height: 16),
                AnswerWidget(retireConfirmText: dailyQuizRetireConfirmText),
                SizedBox(height: 16),
                RetireButton(retireConfirmText: dailyQuizRetireConfirmText),
                SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
