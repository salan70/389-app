import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:common/common.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:model/model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'core/common_widget/loading_widget.dart';
import 'core/util/colors_constant.dart';
import 'core/util/widget_ref_extension.dart';
import 'page/top_page.dart';

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

  // iOS 端末にてステータスバーを表示させるための設定。
  //
  // 参考: https://halzoblog.com/error-bug-diary/20220922-2/
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );

  // 画面の向きを縦で固定する。
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      ProviderScope(
        overrides: [
          flavorProvider.overrideWithValue(Flavor.fromEnvironment),
          searchConditionRepositoryProvider.overrideWith(
            (ref) => SearchConditionRepository(searchConditionBox),
          ),
          notificationSettingRepositoryProvider.overrideWith(
            (ref) => NotificationSettingRepository(notificationSettingBox),
          ),
        ],
        child: const MyApp(),
      ),
    );
  });
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
              if (ref.watch(loadingNotifierProvider)) const LoadingWidget(),
            ],
          );
        },
      ),
      home: const TopPage(),
    );
  }
}
