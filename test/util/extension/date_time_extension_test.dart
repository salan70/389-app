import 'package:baseball_quiz_app/util/extension/date_time_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toFormattedString()', () {
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

    group('calculateDateInApp()', () {
    test('当日判定_2023/1/10 19:00', () {
      // Arrange
      final dateTime = DateTime(2023, 1, 10, 19);

      // Act
      final actual = dateTime.calculateDateInApp();

      // Assert
      final expected = DateTime(2023, 1, 10);
      expect(expected, actual);
    });

    test('前日判定_2023/1/10 18:59', () {
      // Arrange
      final dateTime = DateTime(2023, 1, 10, 18, 59);

      // Act
      final actual = dateTime.calculateDateInApp();

      // Assert
      final expected = DateTime(2023, 1, 9);
      expect(expected, actual);
    });
  });

}
