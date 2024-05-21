import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../util/season_type.dart';

part 'season_repository.g.dart';

@riverpod
SeasonRepository seasonRepository(SeasonRepositoryRef ref) {
  final firestore = ref.watch(firestoreProvider);
  return SeasonRepository(firestore);
}

class SeasonRepository {
  SeasonRepository(this._firestore);

  final FirebaseFirestore _firestore;

  /// [baseDate]を基準として、対象となるシーズンを取得する。
  Future<SeasonType> fetchTargetSeason(DateTime baseDate) async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('seasonPeriods')
        .where('startDate', isLessThanOrEqualTo: baseDate)
        .orderBy('startDate', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // * 対象ドキュメントが見つからなかった場合
      throw FistoreException.notFound();
    }
    // * 対象ドキュメントが見つかった場合
    final DocumentSnapshot document = querySnapshot.docs.first;
    return SeasonType.fromFirestoreValue(document['seasonType'] as String);
  }
}
