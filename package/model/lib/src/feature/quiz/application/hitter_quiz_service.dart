import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../season/util/season_type.dart';
import '../domain/hitter.dart';
import '../infrastructure/hitter_repository.dart';

part 'hitter_quiz_service.g.dart';

@riverpod
HitterQuizService hitterQuizService(HitterQuizServiceRef ref) =>
    HitterQuizService(ref);

/// HitterQuizサービス
///
/// HitterQuizに関する操作を提供する
/// Widgetから呼ばれ、各RepositoryやStateを操作するロジックを実装する
class HitterQuizService {
  HitterQuizService(this.ref);
  final Ref ref;

  /// 選手名で検索する
  Future<List<Hitter>> searchHitter(
    String searchWord,
    SeasonType seasonType,
  ) async {
    final allHitterList =
        await ref.read(allHitterListProvider(seasonType).future);
    final hitterListAfterSearch = <Hitter>[];

    for (final hitter in allHitterList) {
      if (hitter.label.contains(searchWord)) {
        hitterListAfterSearch.add(hitter);
      }
    }

    return hitterListAfterSearch;
  }
}
