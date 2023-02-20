import 'package:baseball_quiz_app/infrastructure/firebase/daily_quiz/firebase_daily_quiz_repository.dart';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  late FirebaseDailyQuizRepository repository;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    repository = FirebaseDailyQuizRepository(
      FakeFirebaseFirestore(),
    );
  });

  group('calculateTodayInApp関数', () {
    test('当日判定_2023/1/10 19:00', () {
      // Arrange
      final dateTime = DateTime(2023, 1, 10, 19);

      // Act
      final actual = repository.calculateTodayInApp(dateTime);

      // Assert
      final expected = DateTime(2023, 1, 10);
      expect(expected, actual);
    });

    test('前日判定_2023/1/10 18:59', () {
      // Arrange
      final dateTime = DateTime(2023, 1, 10, 18, 59);

      // Act
      final actual = repository.calculateTodayInApp(dateTime);

      // Assert
      final expected = DateTime(2023, 1, 9);
      expect(expected, actual);
    });
  });
}
