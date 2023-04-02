import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:version/version.dart';

import '../domain/app_info_repository.dart';

class FirebaseAppInfoRepository implements AppInfoRepository {
  FirebaseAppInfoRepository(this.firestore);

  final FirebaseFirestore firestore;

  /// iOSでプレイするのに必要なアプリバージョンを取得する
  @override
  Future<Version> fetchRequiredAppVersionForIos() async {
    final doc =
        await firestore.collection('config').doc('configDocument').get();
    return Version.parse(doc.data()!['requiredAppVersionForIos'] as String);
  }

  /// Androidでプレイするのに必要なアプリバージョンを取得する
  @override
  Future<Version> fetchRequiredAppVersionForAndroid() async {
    final doc =
        await firestore.collection('config').doc('configDocument').get();
    return Version.parse(doc.data()!['requiredAppVersionForAndroid'] as String);
  }
}
