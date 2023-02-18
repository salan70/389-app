import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../component/banner_ad_widget.dart';
import '../../../component/quiz_widget.dart';
import '../../quiz_result/daily_quiz_result/daily_quiz_result_page.dart';
import '../component/answer_widget.dart';
import '../component/quiz_event_buttons.dart';
import '../component/retire_button.dart';
import 'component/life_widget.dart';

class PlayDailyQuizPage extends StatelessWidget {
  const PlayDailyQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    const dailyQuizRetireConfirmText = '「今日の1問」は1度諦めると2度とプレイできません。\n本当に諦めますか？';
    const maxCanIncorrectCountInDailyQuiz = 2;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              behavior: HitTestBehavior.opaque,
              child: ListView(
                children: const [
                  //TODO: Firestoreに保存したデータを取得し、デイリークイズを作成する
                  //TODO: サーバー時間から、デイリークイズに使用するデータを取得する
                  //TODO: プレイ状況/結果（正誤、成績公開数、不正解数）をFirestoreに保存
                  //TODO: 1日1回しかプレイできなくする
                  // プレイ開始時に、Firestoreにデータを追加

                  /// 軽微そうなやつ
                  //TODO: クイズ正解時に花吹雪出す
                  BannerAdWidget(),
                  SizedBox(height: 16),
                  LifeWidget(),
                  SizedBox(height: 16),
                  QuizWidget(willUpdate: true),
                  SizedBox(height: 16),
                  QuizEventButtons(),
                  SizedBox(height: 16),
                  AnswerWidget(
                    retireConfirmText: dailyQuizRetireConfirmText,
                    maxCanIncorrectCount: maxCanIncorrectCountInDailyQuiz,
                    resultPage: DailyQuizResultPage(),
                  ),
                  SizedBox(height: 16),
                  RetireButton(
                    retireConfirmText: dailyQuizRetireConfirmText,
                    resultPage: DailyQuizResultPage(),
                  ),
                  SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
