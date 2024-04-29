enum StatsType {
  team,
  games,
  pa,
  atBats,
  runs,
  hits,
  twoB,
  threeB,
  hr,
  tb,
  rbi,
  sb,
  cs,
  sac,
  sf,
  bb,
  ibb,
  hbp,
  so,
  gidp,
  avg,
  obp,
  slg,
  ops;

  String get label {
    switch (this) {
      case StatsType.team:
        return '球団';
      case StatsType.games:
        return '試合';
      case StatsType.pa:
        return '打席';
      case StatsType.atBats:
        return '打数';
      case StatsType.runs:
        return '得点';
      case StatsType.hits:
        return '安打';
      case StatsType.twoB:
        return '二塁打';
      case StatsType.threeB:
        return '三塁打';
      case StatsType.hr:
        return '本塁打';
      case StatsType.tb:
        return '塁打';
      case StatsType.rbi:
        return '打点';
      case StatsType.sb:
        return '盗塁';
      case StatsType.cs:
        return '盗塁死';
      case StatsType.sac:
        return '犠打';
      case StatsType.sf:
        return '犠飛';
      case StatsType.bb:
        return '四球';
      case StatsType.ibb:
        return '敬遠';
      case StatsType.hbp:
        return '死球';
      case StatsType.so:
        return '三振';
      case StatsType.gidp:
        return '併殺打';
      case StatsType.avg:
        return '打率';
      case StatsType.obp:
        return '出塁率';
      case StatsType.slg:
        return '長打率';
      case StatsType.ops:
        return 'OPS';
    }
  }
}

enum ResultRank {
  ss,
  s,
  a,
  b,
  c,

  /// 不正解
  incorrect;

  String get label {
    switch (this) {
      case ResultRank.ss:
        return 'SS';
      case ResultRank.s:
        return 'S';
      case ResultRank.a:
        return 'A';
      case ResultRank.b:
        return 'B';
      case ResultRank.c:
        return 'C';
      case ResultRank.incorrect:
        return '不正解';
    }
  }
}

// TODO(me): フォントサイズのconstはそれ用のファイルにまとめたい
// ランクラベルのフォントサイズ
const smallLabelFontSize = 24.0;
const largeLabelFontSize = 40.0;

const statsTypeList = StatsType.values;

/// 確率系のStatsTypeのリスト
final List<String> probabilityStats = [
  StatsType.avg.label,
  StatsType.obp.label,
  StatsType.slg.label,
  StatsType.ops.label,
];
