import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:version/version.dart';

part 'app_info_repository.g.dart';

@riverpod
AppInfoRepository appInfoRepository(AppInfoRepositoryRef ref) {
  final firestore = ref.watch(firestoreProvider);
  return AppInfoRepository(firestore);
}

class AppInfoRepository {
  AppInfoRepository(this.firestore);

  final FirebaseFirestore firestore;

  /// iOS でプレイするのに必要なアプリバージョンを取得する。
  Future<Version> fetchRequiredAppVersionForIos() async {
    final doc =
        await firestore.collection('config').doc('configDocument').get();
    return Version.parse(doc.data()!['requiredAppVersionForIos'] as String);
  }

  /// Android でプレイするのに必要なアプリバージョンを取得する。
  Future<Version> fetchRequiredAppVersionForAndroid() async {
    final doc =
        await firestore.collection('config').doc('configDocument').get();
    return Version.parse(doc.data()!['requiredAppVersionForAndroid'] as String);
  }
}
