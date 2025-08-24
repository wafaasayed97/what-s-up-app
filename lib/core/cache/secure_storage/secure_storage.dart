import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _secureStorage;

  SecureStorage(this._secureStorage);

  Future<void> write(SecureStorageKeys key, String value) async {
    await _secureStorage.write(key: key.name, value: value);
  }

  Future<String?> read(SecureStorageKeys key) async {
    return await _secureStorage.read(key: key.name);
  }

  Future<void> delete(SecureStorageKeys key) async {
    await _secureStorage.delete(key: key.name);
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
}

enum SecureStorageKeys { userToken, localAuthEnabled }
