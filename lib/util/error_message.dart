import 'exception/supabase_exception.dart';

extension ObjectHelper on Object {
  /// エラーメッセージを返す
  String get errorMessage {
    if (this is SupabaseException) {
      final error = this as SupabaseException;
      switch (error.code) {
        case SupabaseExceptionCode.notFound:
          return 'データが見つかりませんでした。';
        case SupabaseExceptionCode.unknown:
          return '不明なエラーが発生しました。nnnn';
      }
    }
    return toString();
  }
}
