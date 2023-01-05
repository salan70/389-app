import '../model/typeadapter/hitter_search_condition.dart';
import 'hitting_stats/stats_type.dart';

// hitterSearchConditionを格納するHiveのBox名
const hitterSearchConditionBoxKey = 'hitterSearchConditionBox';

const defaultHittingSearchCondition = HitterSearchCondition(
  teamList: [
    'オリックス・バファローズ',
    '福岡ソフトバンクホークス',
    '埼玉西武ライオンズ',
    '東北楽天ゴールデンイーグルス',
    '千葉ロッテマリーンズ',
    '北海道日本ハムファイターズ',
  ],
  minGames: 300,
  minHits: 300,
  minHr: 50,
  selectedStatsList: [
    StatsType.year,
    StatsType.team,
    StatsType.avg,
    StatsType.hr,
    StatsType.ops,
  ],
);

// 出題する成績の選択数
// この数ちょうどでなくてはならない
const mustSelectStatsTypeNum = 5;

const errorForSelectStatsTypeValidation = '成績を$mustSelectStatsTypeNumつ選択してください';

const minGamesOptionList = [0, 100, 300, 500, 1000];

const minHitsOptionList = [0, 100, 300, 500, 1000];

const minHrOptionList = [0, 10, 50, 100, 200];
