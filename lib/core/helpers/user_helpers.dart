import '../cache/preferences_storage/preferences_storage.dart';
import '../cache/preferences_storage/preferences_storage_keys.dart';
import '../cache/secure_storage/secure_storage.dart';
import '/core/di/services_locator.dart';

class UserHelpers {
  static bool isLoggedIn() {
    return getPhoneNumber().isNotEmpty;
  }

  static bool isGuest() {
    return sl<PreferencesStorage>()
        .getString(key: PreferencesKeys.uuid)
        .isNotEmpty;
  }

  static bool isFirstTime() {
    return sl<PreferencesStorage>().getBoolean(
      key: PreferencesKeys.firstOpen,
      defaultValue: true,
    );
  }

  static bool isNotLoggedIn() {
    return getPhoneNumber().isEmpty;
  }

  static Future<String> getUserToken() async {
    final userToken = await sl<SecureStorage>().read(
      SecureStorageKeys.userToken,
    );
    return userToken ?? '';
  }

  static String getPhoneNumber() {
    final phone = sl<PreferencesStorage>().getString(
      key: PreferencesKeys.phone,
    );
    return phone;
  }
}
