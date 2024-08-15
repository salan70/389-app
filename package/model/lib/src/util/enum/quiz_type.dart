enum QuizType {
  normal,
  daily;

  String get label {
    switch (this) {
      case QuizType.normal:
        return 'normal';
      case QuizType.daily:
        return 'daily';
    }
  }

  String get retireConfirmText {
    switch (this) {
      case QuizType.normal:
        return '本当に諦めますか？';
      case QuizType.daily:
        return '本当に諦めますか？\n\n※「今日の1問」は1度しか\nプレイできません。';
    }
  }
}
