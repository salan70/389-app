import 'app_exception.dart';

// TODO(me): unknown 以外のエラーを追加する。
class AdmobException extends AppException {
  const AdmobException._([
    super.message = 'admob exception',
    AdmobExceptionCode? code,
  ]) : code = code ?? AdmobExceptionCode.unknown;

  /// 不明なエラー
  factory AdmobException.unknown() => const AdmobException._(
        'An unknown error has occurred.',
        AdmobExceptionCode.unknown,
      );

  /// エラーコード
  final AdmobExceptionCode code;

  @override
  String toString() => 'AdmobExceptionCode[${code.name}]: $message';
}

/// Admob 関連の例外のエラーコード
enum AdmobExceptionCode {
  /// 不明なエラー
  unknown;
}
