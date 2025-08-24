import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_s_up_app/core/cache/preferences_storage/preferences_storage.dart';
import 'package:what_s_up_app/core/cache/secure_storage/secure_storage.dart';

final sl = GetIt.instance;

class ServicesLocator {
 
   Future<void> init() async {
   await _initSharedPreferencesStorage();
    _initFlutterSecureStorage();
    
  }
Future<void> _initSharedPreferencesStorage() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => PreferencesStorage(sharedPreferences));
  }

  void _initFlutterSecureStorage() {
    final secureStorage = FlutterSecureStorage();
    sl.registerLazySingleton(() => SecureStorage(secureStorage));
  }
}