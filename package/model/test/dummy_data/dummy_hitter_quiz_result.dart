import 'package:model/src/feature/quiz/domain/stats_value.dart';
import 'package:model/src/feature/quiz_result/domain/hitter_quiz_result.dart';

final dummyHitterQuizResult = HitterQuizResult(
  docId: 'dummyDocId',
  id: '9d377b08-3b1d-4ff2-892f-597c404e4b7d',
  name: '牧秀悟',
  updatedAt: DateTime(2021, 9, 1, 12),
  yearList: ['2021', '2022', 'NPB：2年'],
  selectedStatsList: ['球団', '打率', '本塁打', 'OPS'],
  statsMapList: [
    {
      '球団': const StatsValue(unveilOrder: 12, data: 'DeNA'),
      '本塁打': const StatsValue(unveilOrder: 11, data: '22'),
      '打率': const StatsValue(unveilOrder: 10, data: '.314'),
      'OPS': const StatsValue(unveilOrder: 9, data: '.890'),
    },
    {
      '球団': const StatsValue(unveilOrder: 12, data: 'DeNA'),
      '本塁打': const StatsValue(unveilOrder: 11, data: '22'),
      '打率': const StatsValue(unveilOrder: 10, data: '.314'),
      'OPS': const StatsValue(unveilOrder: 9, data: '.890'),
    },
    {
      '球団': const StatsValue(unveilOrder: 12, data: 'DeNA'),
      '本塁打': const StatsValue(unveilOrder: 11, data: '22'),
      '打率': const StatsValue(unveilOrder: 10, data: '.314'),
      'OPS': const StatsValue(unveilOrder: 9, data: '.890'),
    },
    {
      '球団': const StatsValue(unveilOrder: 8, data: 'DeNA'),
      '本塁打': const StatsValue(unveilOrder: 7, data: '24'),
      '打率': const StatsValue(unveilOrder: 6, data: '.291'),
      'OPS': const StatsValue(unveilOrder: 5, data: '.861'),
    },
    {
      '球団': const StatsValue(unveilOrder: 4, data: 'NPB：2年'),
      '本塁打': const StatsValue(unveilOrder: 0, data: '46'),
      '打率': const StatsValue(unveilOrder: 1, data: '.302'),
      'OPS': const StatsValue(unveilOrder: 2, data: '.876'),
    }
  ],
  isCorrect: false,
  unveilCount: 0,
  incorrectCount: 0,
);
