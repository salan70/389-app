import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/hitter_quiz_result.dart';
import '../domain/quiz_result_repository.dart';

class FirebaseQuizResultRepository implements QuizResultRepository {
  FirebaseQuizResultRepository(this.firestore);

  final FirebaseFirestore firestore;

  @override
  Future<List<HitterQuizResult>> fetchNormalQuizResultList(User user) async {
    final QuerySnapshot snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('normalQuizResult')
        .orderBy('createdAt', descending: true)
        .get();

    final hitterQuizResultList = <HitterQuizResult>[];
    for (final document in snapshot.docs) {
      final hitterQuizResult =
          HitterQuizResult.fromJson(document.data()! as Map<String, dynamic>);
      hitterQuizResultList.add(hitterQuizResult);
    }

    return hitterQuizResultList;
  }
}
