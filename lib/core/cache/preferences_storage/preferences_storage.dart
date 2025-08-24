import 'package:shared_preferences/shared_preferences.dart';
import 'preferences_storage_keys.dart';

class PreferencesStorage {
  final SharedPreferences _preferences;

  PreferencesStorage(this._preferences);

  Future<void> clear() async {
    await _preferences.clear();
  }

  void putBoolean({required PreferencesKeys key, required bool value}) async {
    await _preferences.setBool(key.name, value);
  }

  bool getBoolean({required PreferencesKeys key, bool defaultValue = false}) {
    return _preferences.getBool(key.name) ?? defaultValue;
  }

  Future<bool> putString({
    required PreferencesKeys key,
    required String? value,
  }) async {
    return await _preferences.setString(key.name, value ?? "");
  }

  String getString({required PreferencesKeys key}) {
    return _preferences.getString(key.name) ?? "";
  }

  String getCurrentLanguage() {
    return _preferences.getString(PreferencesKeys.currentLanguage.name) ?? "ar";
  }

  bool isEnglish() => getCurrentLanguage() == "en";

  bool isArabic() => getCurrentLanguage() == "ar";
}
