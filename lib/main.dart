import 'package:baseball_quiz_app/Infrastructure/supabase/supabase_providers.dart';
import 'package:baseball_quiz_app/model/hitter_search_filter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'repository/supabase/hitter_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .envの読み込み
  await dotenv.load(fileName: ".env");

  // Supabaseの初期化
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_API_KEY']!,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supabase = ref.watch(supabaseProvider);
    final test = HitterRepository(supabase);
    const searchFilter = HitterSearchFilter(
        teamList: ['千葉ロッテマリーンズ', '読売ジャイアンツ'],
        minGames: 1000,
        minHits: 1500,
        minPa: 7396);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
              future: test.implSearchHitter(searchFilter),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  print('error: $snapshot.error');
                  return Text('error: ${snapshot.error.toString()}');
                } else if (snapshot.hasData) {
                  return Text('has Data: ${snapshot.data}');
                } else {
                  return Text('else: ${snapshot.data}');
                }
              }),
        ),
      ),
    );
  }
}
