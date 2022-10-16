import 'package:logger/logger.dart';
import 'package:universal_html/controller.dart';
import 'package:universal_html/html.dart';

class Scraping {
  final logger = Logger();

  fetchCatcher(String url) async {
    final controller = WindowController();
    await controller.openHttp(uri: Uri.parse(url));

    const selector =
        '#mw-content-text > div.mw-parser-output > table:nth-child(17) > tbody > tr';
    final elementList = controller.window!.document.querySelectorAll(selector);

    final List<List<String?>> catcherList = [];

    for (final element in elementList) {
      final catcher = element.querySelector('> td > a');
      if (catcher != null) {
        final url = catcher.attributes['href']!;
        final hometown = await fetchHometown(url);

        catcherList.add([catcher.title!, hometown]);
        await Future.delayed(const Duration(seconds: 5));
      }
    }

    logger.i(['finish', catcherList]);
  }

  Future<String?> fetchHometown(String url) async {
    final controller = WindowController();
    await controller.openHttp(uri: Uri.parse('https://ja.wikipedia.org$url'));

    const selector =
        '#mw-content-text > div.mw-parser-output > table.infobox > tbody > tr:nth-child(5) > td';

    final elementList = controller.window!.document.querySelectorAll(selector);

    for (final element in elementList) {
      return element.querySelector(' > a')!.title;
    }

    return null;
  }
}
