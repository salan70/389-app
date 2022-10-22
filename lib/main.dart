import 'package:baseball_quiz_app/scraping/scraping.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'スクレイピングのサンプルアプリ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scraping = Scraping();
  final _url =
      'https://ja.wikipedia.org/wiki/%E5%BA%83%E5%B3%B6%E6%9D%B1%E6%B4%8B%E3%82%AB%E3%83%BC%E3%83%97%E3%81%AE%E9%81%B8%E6%89%8B%E4%B8%80%E8%A6%A7';

  List<Catcher> _catcherList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _catcherList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            height: 64,
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Colors.black12,
              )),
            ),
            child: Column(
              children: [
                Text(_catcherList[index].name),
                Text(_catcherList[index].hometown),
              ],
            ),
          );
        },
      ),
      floatingActionButton: TextButton(
        onPressed: () async {
          final tmpCatcherList = await _scraping.fetchCatcher(_url);
          setState(() {
            _catcherList = tmpCatcherList;
          });
        },
        child: const Text(
          '広島のキャッチャーをスクレイピング',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
