import 'app_exception.dart';

class SupabaseException extends AppException {
  const SupabaseException._([
    super.message = 'supabase exception',
    SupabaseExceptionCode? code,
  ]) : code = code ?? SupabaseExceptionCode.unknown;

  /// データが見つからない
  factory SupabaseException.notFound() => const SupabaseException._(
        '選手が見つかりませんでした。',
        SupabaseExceptionCode.notFound,
      );

  /// 不明なエラー
  factory SupabaseException.unknown() => const SupabaseException._(
        'An unknown error has occurred.',
        SupabaseExceptionCode.unknown,
      );

  /// エラーコード
  final SupabaseExceptionCode code;

  @override
  String toString() => 'SupabaseExceptionCode[${code.name}]: $message';
}

/// データベース関連の例外のエラーコード
enum SupabaseExceptionCode {
  /// データが見つからない
  notFound,

  /// 不明なエラー
  unknown,
  ;
}
