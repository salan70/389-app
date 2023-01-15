import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Infrastructure/supabase/supabase_providers.dart';
import 'constant/hitter_search_condition_constant.dart';
import 'model/typeadapter/hitter_search_condition.dart';
import 'repository/hitter_repository.dart';
import 'repository/hitter_search_condition_repository.dart';
import 'repository/hive/hive_hitter_search_condition_repository.dart';
import 'repository/supabase/supabase_hitter_repository.dart';
import 'ui/page/prepare_quiz/prepare_quiz_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .envの読み込み
  await dotenv.load();

  // 初期化関連
  await initialize();

  // HiveのBoxをopen
  final hitterSearchConditionBox =
      await Hive.openBox<HitterSearchCondition>(hitterSearchConditionBoxKey);

  runApp(
    ProviderScope(
      overrides: [
        hitterRepositoryProvider.overrideWith(
          (ref) {
            return SupabaseHitterRepository(
              ref.watch(supabaseProvider),
            );
          },
        ),
        hitterSearchConditionRepositoryProvider.overrideWith(
          (ref) {
            return HiveHitterSearchConditionRepository(
              hitterSearchConditionBox,
            );
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> initialize() async {
  // Hiveの初期化
  await Hive.initFlutter();
  Hive.registerAdapter(HitterSearchConditionAdapter());

  // Supabaseの初期化
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_API_KEY']!,
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF8E1),
        dialogBackgroundColor: const Color(0xFFFFF8E1),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF37474F),
          // error: Color(0xFFC62828),
          error: Colors.green,
        ),
      ),
      home: const Scaffold(
        body: Center(child: TextButtonWidget()),
      ),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('クイズの設定をする'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => const PrepareQuizPage(),
          ),
        );
      },
    );
  }
}
