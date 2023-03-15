// ignore_for_file: one_member_abstracts

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'hitter_quiz_result.dart';

final quizResultRepositoryProvider = Provider<QuizResultRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class QuizResultRepository {
  /// normalQuizResultをリストで取得する
  Future<List<HitterQuizResult>> fetchNormalQuizResultList(User user);
}
