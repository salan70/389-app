import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:baseball_quiz_app/feature/analytics/application/analytics_service.dart';
import 'package:baseball_quiz_app/feature/app_review/domain/review_history_repository.dart';
import 'package:baseball_quiz_app/feature/app_review/infrastructure/firebase_review_history_repository.dart';
import 'package:baseball_quiz_app/util/constant/hive_box_type.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'feature/app_info/application/app_info_state.dart';
import 'feature/app_info/domain/app_info_repository.dart';
import 'feature/app_info/infrastructure/firebase_app_info_repository.dart';
import 'feature/auth/application/auth_service.dart';
import 'feature/auth/domain/auth_repository.dart';
import 'feature/auth/domain/user_info_repository.dart';
import 'feature/auth/infrastructure/firebase_auth_provider.dart';
import 'feature/auth/infrastructure/firebase_auth_repository.dart';
import 'feature/auth/infrastructure/firebase_user_info_repository.dart';
import 'feature/daily_quiz/domain/daily_quiz_repository.dart';
import 'feature/daily_quiz/infrastructure/firebase_daily_quiz_repository.dart';
import 'feature/loading/application/loading_state.dart';
import 'feature/loading/presentation/loading_widget.dart';
import 'feature/push_notification/domain/notification_setting.dart';
import 'feature/push_notification/domain/notification_setting_repository.dart';
import 'feature/push_notification/infrastructure/hive_notification_setting_repository.dart';
import 'feature/quiz/application/hitter_quiz_notifier.dart';
import 'feature/quiz/domain/hitter_repository.dart';
import 'feature/quiz/infrastructure/supabase_hitter_repository.dart';
import 'feature/quiz/infrastructure/supabase_providers.dart';
import 'feature/quiz_result/application/quiz_result_state.dart';
import 'feature/quiz_result/domain/quiz_result_repository.dart';
import 'feature/quiz_result/infrastructure/firebase_quiz_result_repository.dart';
import 'feature/search_condition/domain/search_condition.dart';
import 'feature/search_condition/domain/search_condition_repository.dart';
import 'feature/search_condition/infrastructure/hive_search_condition_repository.dart';
import 'feature/top/presentation/top_page.dart';
import 'util/constant/colors_constant.dart';
import 'util/constant/hitting_stats_constant.dart';
import 'util/extension/widget_ref_extension.dart';
import 'util/firebase_instance.dart';
import 'util/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初期化関連
  await initialize();

  // HiveのBoxをopen
  final searchConditionBox =
      await Hive.openBox<SearchCondition>(HiveBoxType.searchCondition.key);
  final notificationSettingBox = await Hive.openBox<NotificationSetting>(
    HiveBoxType.notificationSetting.key,
  );

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
        searchConditionRepositoryProvider.overrideWith(
          (ref) => HiveSearchConditionRepository(searchConditionBox),
        ),
        notificationSettingRepositoryProvider.overrideWith(
          (ref) => HiveNotificationSettingRepository(notificationSettingBox),
        ),
        authRepositoryProvider.overrideWith(
          (ref) {
            return FirebaseAuthRepository(
              ref.watch(firebaseAuthProvider),
            );
          },
        ),
        userInfoRepositoryProvider.overrideWith(
          (ref) {
            return FirebaseUserInfoRepository(
              ref.watch(firestoreProvider),
            );
          },
        ),
        reviewHistoryRepositoryProvider.overrideWith(
          (ref) => FirebaseReviewHistoryRepository(
            ref.watch(firestoreProvider),
          ),
        ),
        dailyQuizRepositoryProvider.overrideWith(
          (ref) {
            return FirebaseDailyQuizRepository(
              ref.watch(firestoreProvider),
            );
          },
        ),
        quizResultRepositoryProvider.overrideWith(
          (ref) {
            return FirebaseQuizResultRepository(
              ref.watch(firestoreProvider),
            );
          },
        ),
        appInfoRepositoryProvider.overrideWith(
          (ref) {
            return FirebaseAppInfoRepository(
              ref.watch(firestoreProvider),
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

  // .envの読み込み
  await dotenv.load();

  // Firebaseの初期化
  await Firebase.initializeApp();

  // Firebase Analytics
  // アプリ起動時にイベントを送信
  await FirebaseAnalytics.instance.logEvent(
    name: 'launch_app',
  );

  // Firebase Crashlytics
  FlutterError.onError = (errorDetails) {
    // Flutterフレームワーク内でスローされたすべてのエラーを送信する
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Flutterフレームワークで処理されないエラーを送信する
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // FCM の通知権限リクエスト
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();

  // トークンの取得（デバッグ用）
  final token = await messaging.getToken();
  logger.i('🐯 FCM TOKEN: $token');

  // Hiveの初期化
  await Hive.initFlutter();
  Hive.registerAdapter(SearchConditionAdapter());
  Hive.registerAdapter(NotificationSettingAdapter());

  // Supabaseの初期化
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_API_KEY']!,
  );

  // table_calendarを日本語で表示するために必要
  await initializeDateFormatting();

  // ローカルPUSH通知を日時に応じて送信するために必要
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Tokyo'));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyApp();
}

class _MyApp extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // main()だとうまく表示されないため、
      // MyAppのinitState()に記載
      // ATTをダイアログ表示
      // AdMobの初期化より前に実行する必要がある
      if (await AppTrackingTransparency.trackingAuthorizationStatus ==
          TrackingStatus.notDetermined) {
        // ATTダイアログがうまく表示されない場合があるため、待機処理を追加
        await Future<void>.delayed(const Duration(milliseconds: 200));
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
      // AdMobの初期化
      await MobileAds.instance.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    // AsyncValueを返すStateProviderの結果をハンドリングする。
    //
    // 実際にそれぞれのProviderを使用するWidgetに書いたほうが良いかも。
    // Providerによっては複数のWidgetで使用するためここで書いている。
    ref.handleAsyncValue<void>(
      hitterQuizNotifierProvider(QuizType.normal),
    );
    ref.handleAsyncValue<void>(
      hitterQuizNotifierProvider(QuizType.daily),
    );
    ref.handleAsyncValue<void>(
      quizResultFunctionStateProvider,
    );
    ref.handleAsyncValue<void>(
      checkNeedUpdateStateProvider,
    );

    // TODO(me): ここで login するのは多分良くないのでなんとかする。
    // Userを作成
    ref.read(authServiceProvider).login();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.rocknRollOneTextTheme().copyWith(
          bodyMedium: GoogleFonts.rocknRollOneTextTheme().bodyMedium?.copyWith(
                fontSize: 16,
              ),
          labelLarge: GoogleFonts.rocknRollOneTextTheme().labelLarge?.copyWith(
                fontSize: 16,
              ),
          headlineSmall:
              GoogleFonts.rocknRollOneTextTheme().headlineSmall?.copyWith(
                    color: primaryColor,
                  ),
        ),
        // ボタン
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
      navigatorObservers: [
        ref.watch(analyticsObserverProvider),
      ],
      builder: (context, child) => Consumer(
        builder: (context, ref, _) {
          return Stack(
            children: [
              child!,
              // ローディングを表示する
              if (ref.watch(loadingProvider)) const LoadingWidget(),
            ],
          );
        },
      ),
      home: const TopPage(),
    );
  }
}
