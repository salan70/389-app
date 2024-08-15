import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

extension GlobalKeyExtension on GlobalKey {
  /// Widget を画像化する。
  /// 参考：
  /// https://zenn.dev/gold_panzee54/articles/210516-flutter-widget-to-image-share#1.-widget%E3%82%92%E7%94%BB%E5%83%8F%E5%8C%96%E3%81%99%E3%82%8B
  Future<ByteData> exportToImage() async {
    final boundary =
        currentContext!.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage(pixelRatio: 3);
    final byteData = await image?.toByteData(format: ImageByteFormat.png);

    return byteData!;
  }
}
