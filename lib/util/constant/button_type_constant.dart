import 'package:flutter/material.dart';

import 'colors_constant.dart';

enum ButtonType {
  main,
  alert,
  sub,
}

extension ButtonTypeExt on ButtonType {
  ButtonStyle get buttonStyle {
    switch (this) {
      case ButtonType.main:
        return TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: primaryColor,
          disabledBackgroundColor: primaryColor.withOpacity(0.4),
          foregroundColor: backgroundColor,
        );

      case ButtonType.alert:
        return TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: errorColor,
          foregroundColor: backgroundColor,
        );
      case ButtonType.sub:
        return TextButton.styleFrom(
          side: const BorderSide(
            width: 2,
            color: primaryColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: backgroundColor,
          foregroundColor: primaryColor,
        );
    }
  }
}
