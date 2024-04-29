import 'package:flutter/material.dart';
import 'package:model/model.dart';

import 'colors_constant.dart';

extension ResultRankExtension on ResultRank {
  Text get smallLabelWidget {
    switch (this) {
      case ResultRank.ss:
        return Text(
          ResultRank.ss.label,
          style: const TextStyle(
            fontSize: smallLabelFontSize,
            color: ssRankColor,
          ),
        );
      case ResultRank.s:
        return Text(
          ResultRank.s.label,
          style: const TextStyle(
            fontSize: smallLabelFontSize,
            color: sRankColor,
          ),
        );
      case ResultRank.a:
        return Text(
          ResultRank.a.label,
          style: const TextStyle(
            fontSize: smallLabelFontSize,
            color: aRankColor,
          ),
        );
      case ResultRank.b:
        return Text(
          ResultRank.b.label,
          style: const TextStyle(
            fontSize: smallLabelFontSize,
            color: bRankColor,
          ),
        );
      case ResultRank.c:
        return Text(
          ResultRank.c.label,
          style: const TextStyle(
            fontSize: smallLabelFontSize,
            color: cRankColor,
          ),
        );
      case ResultRank.incorrect:
        return const Text(
          '✗',
          style: TextStyle(
            fontSize: smallLabelFontSize,
            color: primaryColor,
          ),
        );
    }
  }

  Text get largeLabelWidget {
    switch (this) {
      case ResultRank.ss:
        return Text(
          ResultRank.ss.label,
          style: const TextStyle(
            fontSize: largeLabelFontSize,
            color: ssRankColor,
          ),
        );
      case ResultRank.s:
        return Text(
          ResultRank.s.label,
          style: const TextStyle(
            fontSize: largeLabelFontSize,
            color: sRankColor,
          ),
        );
      case ResultRank.a:
        return Text(
          ResultRank.a.label,
          style: const TextStyle(
            fontSize: largeLabelFontSize,
            color: aRankColor,
          ),
        );
      case ResultRank.b:
        return Text(
          ResultRank.b.label,
          style: const TextStyle(
            fontSize: largeLabelFontSize,
            color: bRankColor,
          ),
        );
      case ResultRank.c:
        return Text(
          ResultRank.c.label,
          style: const TextStyle(
            fontSize: largeLabelFontSize,
            color: cRankColor,
          ),
        );
      case ResultRank.incorrect:
        return const Text(
          '✗',
          style: TextStyle(
            fontSize: largeLabelFontSize,
            color: primaryColor,
          ),
        );
    }
  }
}
