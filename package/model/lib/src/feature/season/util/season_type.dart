/// どの時点で取得したデータかを判別するための enum.
enum SeasonType {
  /// 2022年シーズン終了時。
  ///
  /// 厳密には、 2022-12-04 時点。
  end2022,

  /// 2023年シーズン終了時。
  ///
  /// 厳密には、 2024-01-10 時点。
  end2023;

  static const _end2022 = 'end2022';
  static const _end2023 = 'end2023';

  /// Firestore に保存する値。
  String get firestoreValue {
    switch (this) {
      case SeasonType.end2022:
        return _end2022;
      case SeasonType.end2023:
        return _end2023;
    }
  }

  /// Firestore から取得した値を enum に変換する。
  static SeasonType fromFirestoreValue(String? value) {
    // value が null の場合は、 `QuizSeasonType.end2022` とする。
    //
    // ※ `QuizSeasonType.firestoreValue` を保持するフィールドを作成したのは、
    // `QuizSeasonType.end2023` 実装時であるため。
    if (value == null) {
      return SeasonType.end2022;
    }

    switch (value) {
      case _end2022:
        return SeasonType.end2022;
      case _end2023:
        return SeasonType.end2023;
      default:
        throw ArgumentError('不正な値です: $value');
    }
  }

  /// 野手の基本情報を格納するテーブルの名称。
  String get hitterTable {
    switch (this) {
      case SeasonType.end2022:
        return 'hitter_table';
      case SeasonType.end2023:
        return 'hitter_table_20240110';
    }
  }

  /// 野手の成績を格納するテーブルの名称。
  String get hittingStatsTable {
    switch (this) {
      case SeasonType.end2022:
        return 'hitting_stats_table';
      case SeasonType.end2023:
        return 'hitting_stats_table_20240110';
    }
  }
}
