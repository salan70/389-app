import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../util/constant/text_in_app.dart';
import '../../../util/logger.dart';

final shareQuizResultServiceProvider =
    Provider.autoDispose<ShareQuizResultService>(ShareQuizResultService.new);

/// お問い合わせ関連の処理を行うサービスクラス
class ShareQuizResultService {
  ShareQuizResultService(
    this.ref,
  );

  final Ref ref;

  /// ディレクトへのパスを取得し、シェアする
  Future<void> shareImageAndText(String text, GlobalKey globalKey) async {
    // shareする際のテキスト
    try {
      final bytes = await _exportToImage(globalKey);

      // byte data→Uint8List
      final widgetImageBytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

      // App directoryファイルに保存
      final applicationDocumentsFile =
          await _getApplicationDocumentsFile(text, widgetImageBytes);

      final path = applicationDocumentsFile.path;

      await Share.shareXFiles([XFile(path)], text: shareText);
      await applicationDocumentsFile.delete();
    } on Exception catch (error) {
      logger.e(error);
    }
  }

  /// Widgetを画像化する
  /// 参考：
  /// https://zenn.dev/gold_panzee54/articles/210516-flutter-widget-to-image-share#1.-widget%E3%82%92%E7%94%BB%E5%83%8F%E5%8C%96%E3%81%99%E3%82%8B
  Future<ByteData> _exportToImage(GlobalKey globalKey) async {
    final boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;

    final image = await boundary?.toImage(
      pixelRatio: 3,
    );

    final byteData = await image?.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return byteData!;
  }

  /// 作成した画像をアプリ内のディレクトリへ保存しパスを取得する
  Future<File> _getApplicationDocumentsFile(
    String text,
    List<int> imageData,
  ) async {
    final directory = await getApplicationDocumentsDirectory();

    final exportFile = File('${directory.path}/$text.png');
    if (!exportFile.existsSync()) {
      await exportFile.create(recursive: true);
    }
    final file = await exportFile.writeAsBytes(imageData);
    return file;
  }
}
