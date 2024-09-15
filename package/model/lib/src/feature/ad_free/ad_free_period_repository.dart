import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ad_free_period_repository.g.dart';

@riverpod
AdFreePeriodRepository adFreePeriodRepository(AdFreePeriodRepositoryRef ref) {
  final firestore = ref.watch(firestoreProvider);
  return AdFreePeriodRepository(firestore);
}

class AdFreePeriodRepository {
  const AdFreePeriodRepository(this.firestore);

  final FirebaseFirestore firestore;

  /// 広告非表示期間の終了日時を取得する。
  Stream<DateTime> streamEndTime(String userId) {
    final snapshot = firestore
        .collection('users')
        .doc(userId)
        .collection('adFreePeriod')
        .doc('current')
        .snapshots();

    final endTime = snapshot.map((snapshot) {
      final endAtAdFreePeriod =
          snapshot.data()?['endAtAdFreePeriod'] as Timestamp?;
      if (!snapshot.exists || endAtAdFreePeriod == null) {
        throw FirestoreException.notFound();
      }

      return endAtAdFreePeriod.toDate();
    });

    return endTime;
  }
}
