import 'package:baseball_quiz_app/util/extension/date_time_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('quiz.formattedUpdatedAtText', () {
    test('2021/01/01', () {
      // Arrange
      final date = DateTime(2021, 1, 1, 0, 30);

      // Act
      final result = date.toFormattedString();

      // Assert
      const expected = '2021/01/01';
      expect(expected, result);
    });
  });
}
