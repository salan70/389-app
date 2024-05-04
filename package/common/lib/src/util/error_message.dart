import 'exception/supabase_exception.dart';

extension ObjectHelper on Object {
  /// エラーメッセージを返す
  String get errorMessage {
    const defaultMessage = 'エラーが発生しました。\n時間をおいて再度お試しください。';
    if (this is SupabaseException) {
      final error = this as SupabaseException;
      switch (error.code) {
        case SupabaseExceptionCode.notFound:
          return '選手が見つかりませんでした。\n別の条件をお試しください...!';
        case SupabaseExceptionCode.unknown:
          return defaultMessage;
      }
    }
    return defaultMessage;
  }
}
