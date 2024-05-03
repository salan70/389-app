import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  // * ------ MediaQuery ------ * //
  bool get isDark => MediaQuery.platformBrightnessOf(this) == Brightness.dark;
  double get deviceWidth => MediaQuery.sizeOf(this).width;
  double get deviceHeight => MediaQuery.sizeOf(this).height;
  double get viewInsetsBottom => MediaQuery.viewInsetsOf(this).bottom;
  bool get isIphoneSE1 =>
      deviceWidth == 320 && deviceHeight == 568; // iPhone SE 1st
  bool get isTablet =>
      MediaQuery.sizeOf(this).shortestSide >=
      600; // https://stackoverflow.com/a/54136738
  double get appBarHeight => MediaQuery.paddingOf(this).top + kToolbarHeight;
  Orientation get orientation => MediaQuery.orientationOf(this);

  // * ------ Theme ------ * //
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;

  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;
  TextStyle get bodyVerySmall =>
      Theme.of(this).textTheme.bodySmall!.copyWith(fontSize: 10);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // * ------ Function ------ * //
  void hideKeyboard() {
    // https://github.com/flutter/flutter/issues/54277#issuecomment-640998757
    final currentScope = FocusScope.of(this);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// ダイアログを閉じる際に使うことを想定している。
  void pop() => Navigator.of(this).pop();
}
