import 'app_exception.dart';

class FistoreException extends AppException {
  const FistoreException._([
    super.message = 'firestore exception',
    FistoreExceptionCode? code,
  ]) : code = code ?? FistoreExceptionCode.unknown;

  /// データが見つからない
  factory FistoreException.notFound() => const FistoreException._(
        'データが見つかりませんでした。',
        FistoreExceptionCode.notFound,
      );

  /// 不明なエラー
  factory FistoreException.unknown() => const FistoreException._(
        'An unknown error has occurred.',
        FistoreExceptionCode.unknown,
      );

  /// エラーコード
  final FistoreExceptionCode code;

  @override
  String toString() => 'FirestoreExceptionCode[${code.name}]: $message';
}

/// データベース関連の例外のエラーコード
enum FistoreExceptionCode {
  /// データが見つからない
  notFound,

  /// 不明なエラー
  unknown,
  ;
}
