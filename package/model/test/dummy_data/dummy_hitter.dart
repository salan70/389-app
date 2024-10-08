import 'package:model/src/feature/quiz/domain/hitter_quiz.dart';
import 'package:model/src/feature/quiz/domain/stats_value.dart';
import 'package:model/src/feature/quiz/infrastructure/entity/hitting_stats.dart';
import 'package:model/src/feature/quiz/infrastructure/entity/supabase_hitter.dart';
import 'package:model/src/feature/search_condition/domain/search_condition.dart';
import 'package:model/src/feature/season/util/season_type.dart';

const dummyHitter = SupabaseHitter(
  id: '9d377b08-3b1d-4ff2-892f-597c404e4b7d',
  name: '牧秀悟',
  team: '横浜DeNAベイスターズ',
  hasData: true,
);

const dummyHittingStats = HittingStats(
  stats: {
    '年度': '2021',
    '球団': 'DeNA',
    '試合': 137,
    '打席': 523,
    '打数': 487,
    '得点': 73,
    '安打': 153,
    '二塁打': 35,
    '三塁打': 3,
    '本塁打': 22,
    '塁打': 260,
    '打点': 71,
    '盗塁': 2,
    '盗塁死': 1,
    '犠打': 1,
    '犠飛': 2,
    '四球': 27,
    '敬遠': 0,
    '死球': 6,
    '三振': 85,
    '併殺打': 16,
    '打率': 0.314,
    '出塁率': 0.356,
    '長打率': 0.534,
    'OPS': 0.89,
    'playerId': '9d377b08-3b1d-4ff2-892f-597c404e4b7d',
  },
);

final dummyHittingStatsList = [
  const HittingStats(
    stats: {
      '年度': '2021',
      '球団': 'DeNA',
      '試合': 137,
      '打席': 523,
      '打数': 487,
      '得点': 73,
      '安打': 153,
      '二塁打': 35,
      '三塁打': 3,
      '本塁打': 22,
      '塁打': 260,
      '打点': 71,
      '盗塁': 2,
      '盗塁死': 1,
      '犠打': 1,
      '犠飛': 2,
      '四球': 27,
      '敬遠': 0,
      '死球': 6,
      '三振': 85,
      '併殺打': 16,
      '打率': 0.314,
      '出塁率': 0.356,
      '長打率': 0.534,
      'OPS': 0.89,
      'playerId': '9d377b08-3b1d-4ff2-892f-597c404e4b7d',
    },
  ),
  const HittingStats(
    stats: {
      '年度': '2022',
      '球団': 'DeNA',
      '試合': 135,
      '打席': 568,
      '打数': 509,
      '得点': 63,
      '安打': 148,
      '二塁打': 36,
      '三塁打': 1,
      '本塁打': 24,
      '塁打': 258,
      '打点': 87,
      '盗塁': 3,
      '盗塁死': 3,
      '犠打': 0,
      '犠飛': 6,
      '四球': 43,
      '敬遠': 4,
      '死球': 10,
      '三振': 82,
      '併殺打': 14,
      '打率': 0.291,
      '出塁率': 0.354,
      '長打率': 0.507,
      'OPS': 0.861,
      'playerId': '9d377b08-3b1d-4ff2-892f-597c404e4b7d',
    },
  ),
  const HittingStats(
    stats: {
      '年度': 'NPB：2年',
      '球団': 'NPB：2年',
      '試合': 272,
      '打席': 1091,
      '打数': 996,
      '得点': 136,
      '安打': 301,
      '二塁打': 71,
      '三塁打': 4,
      '本塁打': 46,
      '塁打': 518,
      '打点': 158,
      '盗塁': 5,
      '盗塁死': 4,
      '犠打': 1,
      '犠飛': 8,
      '四球': 70,
      '敬遠': 4,
      '死球': 16,
      '三振': 167,
      '併殺打': 30,
      '打率': 0.302,
      '出塁率': 0.355,
      '長打率': 0.52,
      'OPS': 0.876,
      'playerId': '9d377b08-3b1d-4ff2-892f-597c404e4b7d',
    },
  ),
];

const dummySearchCondition = SearchCondition(
  teamList: ['横浜DeNAベイスターズ'],
  minGames: 100,
  minHits: 100,
  minHr: 10,
  selectedStatsList: ['球団', '打率', '本塁打', 'OPS'],
);

const dummyHitterQuiz = HitterQuiz(
  hitterId: '9d377b08-3b1d-4ff2-892f-597c404e4b7d',
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
  seasonType: SeasonType.end2022,
);
