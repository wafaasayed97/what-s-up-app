

import 'package:what_s_up_app/core/cache/hive/hive_keys.dart';
import 'package:what_s_up_app/core/cache/preferences_storage/preferences_storage.dart';

import '../cache/hive/hive_helper.dart';
import '../cache/secure_storage/secure_storage.dart';

class SessionManager {
  final SecureStorage storage;
  final PreferencesStorage preferencesStorage;
  final HiveHelper hiveHelper;
  SessionManager(this.storage, this.preferencesStorage, this.hiveHelper);

  Future<void> handleUnauthorized() async {
    await storage.deleteAll();
    await Future.wait([
      hiveHelper.clear(),
      hiveHelper.delete(HiveKeys.profile),
    ]);
  }
}
