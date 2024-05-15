import 'package:model/src/feature/quiz/domain/hitter_quiz.dart';
import 'package:model/src/feature/quiz/domain/stats_value.dart';
import 'package:model/src/feature/quiz_result/domain/hitter_quiz_result.dart';

const dummyHitterQuiz = HitterQuiz(
  hitterId: 'dummyHitterId',
  hitterName: '牧秀悟',
  yearList: ['2021', '2022', 'NPB：2年'],
  selectedStatsList: ['球団', '打率', '本塁打', 'OPS'],
  statsMapList: [
    {
      '球団': StatsValue(unveilOrder: 12, data: 'DeNA'),
      '本塁打': StatsValue(unveilOrder: 11, data: '22'),
      '打率': StatsValue(unveilOrder: 10, data: '.314'),
      'OPS': StatsValue(unveilOrder: 9, data: '.890'),
    },
    {
      '球団': StatsValue(unveilOrder: 8, data: 'DeNA'),
      '本塁打': StatsValue(unveilOrder: 7, data: '24'),
      '打率': StatsValue(unveilOrder: 6, data: '.291'),
      'OPS': StatsValue(unveilOrder: 5, data: '.861'),
    },
    {
      '球団': StatsValue(unveilOrder: 4, data: 'NPB：2年'),
      '本塁打': StatsValue(unveilOrder: 0, data: '46'),
      '打率': StatsValue(unveilOrder: 1, data: '.302'),
      'OPS': StatsValue(unveilOrder: 2, data: '.876'),
    }
  ],
  unveilCount: 0,
  incorrectCount: 0,
);

final dummyHitterQuizResult = HitterQuizResult(
  docId: 'dummyDocId',
  updatedAt: DateTime(2021, 9, 1, 12),
  isCorrect: false,
  hitterQuiz: dummyHitterQuiz,
);
