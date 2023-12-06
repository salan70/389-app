import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:roggle/roggle.dart';

final logger = kReleaseMode
    ? Roggle.crashlytics(
        printer: CrashlyticsPrinter(
          // error 以上のログを送信する。
          errorLevel: Level.error,
          onError: (event) {
            FirebaseCrashlytics.instance.recordError(
              event.exception,
              event.stack,
              // エラーレポートを即時送信する。
              fatal: true,
            );
          },
          onLog: (event) {
            // ここで記録したログは、firebase コンソールのログタブに表示される。
            FirebaseCrashlytics.instance.log(event.message);
          },
        ),
      )
    : Roggle(
        printer: SinglePrettyPrinter(
          loggerName: '[APP]',
          stackTraceLevel: Level.error,
          stackTraceMethodCount: 10,
          stackTracePrefix: '>>> ',
          // ログが長くなるので非表示。
          printCaller: false,
        ),
      );
