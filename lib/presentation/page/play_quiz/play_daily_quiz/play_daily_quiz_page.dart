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
    const dailyQuizRetireConfirmText = '本当に諦めますか？\n\n※「今日の1問」は1度しか\nプレイできません。';
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
                  //TODO: プレイ状況/結果（正誤、成績公開数、不正解数）をFirestoreに保存
                  // -> 開始時と終了時に更新する(users > [id] > dailyQuizResult > [id])
                  // ---> 1日1回しかプレイできなくする done!
                  // ----> Top画面にて、userのdailyQuizResultを取得し、該当の
                  //       quizIdが登録されている場合はボタンを非活性にする(TopPageのボタンのinitState)
                  // --> 終了時はisCorrect, showStatsCount, incorrectCount,
                  //     updatedAtを保存

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
