/// アプリ内で使用する例外型のインターフェース。
abstract class AppException implements Exception {
  const AppException(this.message);

  final Object message;
}
