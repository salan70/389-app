import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_repository.g.dart';

@riverpod
UserInfoRepository userInfoRepository(UserInfoRepositoryRef ref) {
  final firestore = ref.watch(firestoreProvider);
  return UserInfoRepository(firestore);
}

class UserInfoRepository {
  UserInfoRepository(this.firestore);

  final FirebaseFirestore firestore;

  Future<void> updateUserInfo(User user) async {
    await firestore.collection('users').doc(user.uid).set(<String, dynamic>{
      'createdAt': user.metadata.creationTime,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
