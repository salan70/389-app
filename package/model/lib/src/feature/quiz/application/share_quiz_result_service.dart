import 'dart:io';

import 'package:common/common.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'share_quiz_result_service.g.dart';

@riverpod
ShareQuizResultService shareQuizResultService(ShareQuizResultServiceRef ref) =>
    ShareQuizResultService(ref);

/// お問い合わせ関連の処理を行うサービスクラス
class ShareQuizResultService {
  ShareQuizResultService(
    this.ref,
  );

  final Ref ref;

  /// 画像の [ByteData] （[bytes]）と [text] をシェアする。
  Future<void> shareImageAndText(
    String text,
    ByteData bytes,
    String shareText,
  ) async {
    try {
      // byte data → Uint8List
      final widgetImageBytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

      // App directory ファイルに保存
      final applicationDocumentsFile =
          await _getApplicationDocumentsFile(text, widgetImageBytes);

      final path = applicationDocumentsFile.path;

      await Share.shareXFiles([XFile(path)], text: shareText);
      await applicationDocumentsFile.delete();
    } on Exception catch (e, s) {
      logger.e(e, s);
    }
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
