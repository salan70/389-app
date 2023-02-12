import 'package:baseball_quiz_app/domain/entity/hitter_quiz.dart';
import 'package:baseball_quiz_app/domain/entity/hitter_search_condition.dart';
import 'package:baseball_quiz_app/domain/entity/stats_value.dart';
import 'package:baseball_quiz_app/infrastructure/supabase/hitter/entity/hitting_stats.dart';
import 'package:baseball_quiz_app/infrastructure/supabase/hitter/entity/supabase_hitter.dart';

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
    'playerId': '9d377b08-3b1d-4ff2-892f-597c404e4b7d'
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
      'playerId': '9d377b08-3b1d-4ff2-892f-597c404e4b7d'
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
      'playerId': '9d377b08-3b1d-4ff2-892f-597c404e4b7d'
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
      'playerId': '9d377b08-3b1d-4ff2-892f-597c404e4b7d'
    },
  )
];

const dummyHitterSearchCondition = HitterSearchCondition(
  teamList: ['横浜DeNAベイスターズ'],
  minGames: 100,
  minHits: 100,
  minHr: 10,
  selectedStatsList: ['年度', '球団', '打率', '本塁打', 'OPS'],
);

const dummyHitterQuiz = HitterQuiz(
  id: '9d377b08-3b1d-4ff2-892f-597c404e4b7d',
  name: '牧秀悟',
  selectedStatsList: ['年度', '球団', '打率', '本塁打', 'OPS'],
  statsMapList: [
    {
      '年度':
          StatsValue(id: 'a6c8e4c9-a760-4961-b794-db387e5a57f0', data: '2021'),
      '球団':
          StatsValue(id: 'c5934786-5ba8-4f2d-810d-2e1d4efb56bc', data: 'DeNA'),
      '本塁打': StatsValue(id: '57e75233-1f17-441e-9bbf-5d4bc0d794bc', data: '22'),
      '打率':
          StatsValue(id: '1eef5e1a-74a5-4bce-a85f-2f7c9eb8bf5f', data: '.314'),
      'OPS':
          StatsValue(id: '5ba7aa8b-11b0-4a20-9d07-5f02751dde28', data: '.890')
    },
    {
      '年度':
          StatsValue(id: '98d48a72-bc1a-4344-b485-f49870a2085d', data: '2022'),
      '球団':
          StatsValue(id: '71166687-c520-45f3-ae97-bff3aac59da3', data: 'DeNA'),
      '本塁打': StatsValue(id: '468dd439-2d4c-4a84-b14a-754b647b7975', data: '24'),
      '打率':
          StatsValue(id: '08c4b792-1011-4cfc-b66f-287b6de6d992', data: '.291'),
      'OPS':
          StatsValue(id: 'a2ae8dfb-b059-4f5f-b82b-7de727727e8f', data: '.861')
    },
    {
      '年度': StatsValue(
        id: '2b38195c-7a4a-46cc-b58b-cf2e949937b8',
        data: 'NPB：2年',
      ),
      '球団': StatsValue(
        id: '4ca86053-0985-4c99-8890-3e05e075b158',
        data: 'NPB：2年',
      ),
      '本塁打': StatsValue(id: '3647eae3-d0e4-4302-8338-01f5d7dd60f1', data: '46'),
      '打率':
          StatsValue(id: '7cdcec0c-b86c-464e-a2b2-03c70488fbc8', data: '.302'),
      'OPS':
          StatsValue(id: 'de48b02c-7707-4f8c-a302-9ba09ad4a05d', data: '.876')
    }
  ],
  hiddenStatsIdList: [
    'c5934786-5ba8-4f2d-810d-2e1d4efb56bc',
    '57e75233-1f17-441e-9bbf-5d4bc0d794bc',
    '1eef5e1a-74a5-4bce-a85f-2f7c9eb8bf5f',
    '5ba7aa8b-11b0-4a20-9d07-5f02751dde28',
    '71166687-c520-45f3-ae97-bff3aac59da3',
    '468dd439-2d4c-4a84-b14a-754b647b7975',
    '08c4b792-1011-4cfc-b66f-287b6de6d992',
    'a2ae8dfb-b059-4f5f-b82b-7de727727e8f',
    '4ca86053-0985-4c99-8890-3e05e075b158',
    '3647eae3-d0e4-4302-8338-01f5d7dd60f1',
    '7cdcec0c-b86c-464e-a2b2-03c70488fbc8',
    'de48b02c-7707-4f8c-a302-9ba09ad4a05d'
  ],
);
