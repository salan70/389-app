import 'package:baseball_quiz_app/feature/app_review/domain/review_history.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_history_repository.g.dart';

@riverpod
ReviewHistoryRepository reviewHistoryRepository(
  ReviewHistoryRepositoryRef ref,
) =>
    throw UnimplementedError('Provider was not initialized');

abstract class ReviewHistoryRepository {
  /// [ReviewHistory] を取得する。
  ///
  /// 存在しない場合は null を返す。
  Future<ReviewHistory?> fetch(String userId);

  /// [ReviewHistory] を作成する。
  Future<void> create(String userId);

  /// [ReviewHistory] を更新する。
  Future<void> update(String userId);
}
