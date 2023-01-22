import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Infrastructure/supabase/supabase_providers.dart';
import 'constant/color_constant.dart';
import 'constant/hitter_search_condition_constant.dart';
import 'model/typeadapter/hitter_search_condition.dart';
import 'repository/hitter_repository.dart';
import 'repository/hitter_search_condition_repository.dart';
import 'repository/hive/hive_hitter_search_condition_repository.dart';
import 'repository/supabase/supabase_hitter_repository.dart';
import 'state/hitter_quiz_ui_state.dart';
import 'state/key_providers.dart';
import 'state/loading_state.dart';
import 'ui/component/quiz_loading_widget.dart';
import 'ui/page/top/top_page.dart';
import 'util/widget_ref_extension.dart';

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
  WidgetsFlutterBinding.ensureInitialized();

  // Firebaseの初期化
  await Firebase.initializeApp();

  // Firebase Crashlytics
  // Flutterフレームワーク内でスローされたすべてのエラーを送信する
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // hitterQuizUiNotifierProviderの結果をハンドリングする
    ref.handleAsyncValue<void>(
      hitterQuizUiStateProvider,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.rocknRollOneTextTheme(),
        primaryColor: highlightColor,
        canvasColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        dialogBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          error: errorColor,
          background: backgroundColor,
        ),
      ),
      navigatorKey: ref.watch(navigatorKeyProvider),
      builder: (context, child) => Consumer(
        builder: (context, ref, _) {
          final isLoading = ref.watch(loadingProvider);
          return Stack(
            children: [
              child!,
              // ローディングを表示する
              if (isLoading) const QuizLoadingWidget(),
            ],
          );
        },
      ),
      home: const TopPage(),
    );
  }
}
