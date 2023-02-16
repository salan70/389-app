import '../../domain/entity/search_condition.dart';
import 'hitting_stats/stats_type.dart';

/// searchConditionを格納するHiveのBox名
const searchConditionBoxKey = 'searchConditionBox';

final defaultSearchCondition = SearchCondition(
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
    StatsType.year.label,
    StatsType.team.label,
    StatsType.avg.label,
    StatsType.hr.label,
    StatsType.ops.label,
  ],
);

/// 出題する成績の選択数
///
/// この数ちょうどでなくてはならない
const mustSelectStatsNum = 5;

const minChoseTeamNum = 1;

const errorForChoseTeamValidation = '球団を$minChoseTeamNumつ以上選択してください';

const errorForSelectStatsValidation = '成績を$mustSelectStatsNumつ選択してください';

const minGamesOptionList = [0, 100, 300, 500, 1000];

const minHitsOptionList = [0, 100, 300, 500, 1000];

const minHrOptionList = [0, 10, 50, 100, 200];
