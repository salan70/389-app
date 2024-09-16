import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rewarded_ad_history_repository.g.dart';

@riverpod
RewardedAdHistoryRepository rewardedAdHistoryRepository(
  RewardedAdHistoryRepositoryRef ref,
) {
  final firestore = ref.read(firestoreProvider);
  return RewardedAdHistoryRepository(firestore);
}

class RewardedAdHistoryRepository {
  const RewardedAdHistoryRepository(this.firestore);

  final FirebaseFirestore firestore;

  /// リワード広告視聴履歴を新規作成する。
  Future<void> createRewardedAdHistory(String userId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('rewardedAdHistories')
        .add({
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// [startOfDay] から [endOfDay] までの期間のリワード広告視聴回数を取得する。
  Future<int> fetchWatchAdCount(
    String userId,
    DateTime startOfDay,
    DateTime endOfDay,
  ) async {
    final querySnapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('rewardedAdHistories')
        .where('createdAt', isGreaterThanOrEqualTo: startOfDay)
        .where('createdAt', isLessThan: endOfDay)
        .get();

    return querySnapshot.docs.length;
  }
}
