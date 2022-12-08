import 'package:baseball_quiz_app/Infrastructure/supabase/supabase_providers.dart';
import 'package:baseball_quiz_app/repository/supabase/hitter_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO 依存性を逆転させる
final hitterRepositoryProvider = Provider((ref) {
  final supabase = ref.watch(supabaseProvider);
  return HitterRepository(supabase);
});
