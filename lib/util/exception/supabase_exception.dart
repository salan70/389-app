import 'base_exception.dart';

/// Supabase関連の処理に使用する例外型。
class ApiException extends AppException implements Exception {
  const ApiException({
    super.message,
    super.defaultMessage = 'エラーが発生しました。',
  });
}

/// 選手を検索時、検索結果が0だった際の例外
class NotFoundPlayerException extends ApiException {
  const NotFoundPlayerException({super.message})
      : super(
          defaultMessage: '選手が見つかりませんでした。',
        );
}
