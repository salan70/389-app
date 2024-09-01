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
  Future<DateTime> fetchEndTime(String userId) async {
    final doc = await firestore
        .collection('users')
        .doc(userId)
        .collection('adFreePeriod')
        .doc('current')
        .get();

    final endTime = doc.data()?['endTime'] as Timestamp?;
    if (!doc.exists || endTime == null) {
      throw FirestoreException.notFound();
    }

    return endTime.toDate();
  }
}
