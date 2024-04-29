import 'package:model/src/feature/daily_quiz/infrastructure/firebase_daily_quiz_repository.dart';

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

  group('formatSelectedStatsList関数', () {
    test('年度以外の文字列が含まれている場合、それらを含む新しいリストが返されること', () {
      // Arrange
      final selectedStatsList = ['年度', '打率', '本塁打', '打点'];

      // Act
      final actual = repository.formatSelectedStatsList(selectedStatsList);

      // Assert
      final expected = ['打率', '本塁打', '打点'];
      expect(expected, actual);
    });

    test('年度以外の文字列が含まれていない場合、引数とリストが返されること', () {
      // Arrange
      final selectedStatsList = ['打率', '本塁打', '打点'];

      // Act
      final actual = repository.formatSelectedStatsList(selectedStatsList);

      // Assert
      final expected = ['打率', '本塁打', '打点'];
      expect(expected, actual);
    });

    test('年度以外の文字列が含まれていない場合、空のリストが返されること', () {
      // Arrange
      final selectedStatsList = ['年度'];

      // Act
      final actual = repository.formatSelectedStatsList(selectedStatsList);

      // Assert
      final expected = <String>[];
      expect(expected, actual);
    });

    test('空のリストが与えられた場合、空のリストが返されること', () {
      // Arrange
      final selectedStatsList = <String>[];

      // Act
      final actual = repository.formatSelectedStatsList(selectedStatsList);

      // Assert
      final expected = <String>[];
      expect(expected, actual);
    });
  });
}
