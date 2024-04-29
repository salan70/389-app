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

  group('lastDayOfMonth', () {
    test('lastDayOfMonth returns the correct last day of the month', () {
      // Arrange: Prepare the test cases
      final testCases = [
        {'date': DateTime(2022), 'expectedLastDay': DateTime(2022, 1, 31)},
        {'date': DateTime(2022, 2), 'expectedLastDay': DateTime(2022, 2, 28)},
        {'date': DateTime(2022, 3), 'expectedLastDay': DateTime(2022, 3, 31)},
        {'date': DateTime(2022, 4), 'expectedLastDay': DateTime(2022, 4, 30)},
        {'date': DateTime(2022, 5), 'expectedLastDay': DateTime(2022, 5, 31)},
        {'date': DateTime(2022, 6), 'expectedLastDay': DateTime(2022, 6, 30)},
        {'date': DateTime(2022, 7), 'expectedLastDay': DateTime(2022, 7, 31)},
        {'date': DateTime(2022, 8), 'expectedLastDay': DateTime(2022, 8, 31)},
        {'date': DateTime(2022, 9), 'expectedLastDay': DateTime(2022, 9, 30)},
        {'date': DateTime(2022, 10), 'expectedLastDay': DateTime(2022, 10, 31)},
        {'date': DateTime(2022, 11), 'expectedLastDay': DateTime(2022, 11, 30)},
        {'date': DateTime(2022, 12), 'expectedLastDay': DateTime(2022, 12, 31)},
        {
          'date': DateTime(2024, 2),
          'expectedLastDay': DateTime(2024, 2, 29),
        }, // Leap year
      ];

      // Run the test cases
      for (final testCase in testCases) {
        // Arrange: Extract the date and expectedLastDay from the testCase
        final date = testCase['date']!;

        // Act: Call the lastDayOfMonth property on the date object
        final actualLastDay = date.lastDayOfMonth;

        // Assert: Check if the actualLastDay is equal to the expectedLastDay
        final expectedLastDay = testCase['expectedLastDay']!;
        expect(actualLastDay, expectedLastDay);
      }
    });
  });
}
