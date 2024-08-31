import 'app_exception.dart';

class FirestoreException extends AppException {
  const FirestoreException._([
    super.message = 'firestore exception',
    FistoreExceptionCode? code,
  ]) : code = code ?? FistoreExceptionCode.unknown;

  /// データが見つからない
  factory FirestoreException.notFound() => const FirestoreException._(
        'データが見つかりませんでした。',
        FistoreExceptionCode.notFound,
      );

  /// 不明なエラー
  factory FirestoreException.unknown() => const FirestoreException._(
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
