import 'package:logger/logger.dart';
import 'package:universal_html/controller.dart';

class Scraping {
  final logger = Logger();

  Future<List<Catcher>> fetchCatcher(String url) async {
    final controller = WindowController();
    await controller.openHttp(uri: Uri.parse(url));

    const selector =
        '#mw-content-text > div.mw-parser-output > table:nth-child(17) > tbody > tr';
    final elementList = controller.window!.document.querySelectorAll(selector);

    final List<Catcher> catcherList = [];

    for (final element in elementList) {
      final catcher = element.querySelector('> td > a');
      if (catcher != null) {
        final name = catcher.title!;

        final url = catcher.attributes['href']!;
        final hometown = await fetchHometown(url);

        catcherList.add(Catcher(name, hometown));
        await Future.delayed(const Duration(seconds: 3));
      }
    }

    return catcherList;
  }

  Future<String> fetchHometown(String url) async {
    final controller = WindowController();
    await controller.openHttp(uri: Uri.parse('https://ja.wikipedia.org$url'));

    const selector =
        '#mw-content-text > div.mw-parser-output > table.infobox > tbody > tr:nth-child(5) > td';

    final elementList = controller.window!.document.querySelectorAll(selector);

    for (final element in elementList) {
      return element.querySelector(' > a')!.title!;
    }

    return '';
  }
}

class Catcher {
  final String name;
  final String hometown;

  Catcher(this.name, this.hometown);
}
