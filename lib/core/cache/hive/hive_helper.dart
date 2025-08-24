import 'package:hive_flutter/hive_flutter.dart';
import 'package:what_s_up_app/core/cache/hive/hive_keys.dart';

class HiveHelper {
  static const String appBoxKey = 'tmg_drop_box';

  late Box<dynamic> _appBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _appBox = await Hive.openBox(appBoxKey);
  }

  Box<dynamic> get appBox => _appBox;

  Future<void> write(HiveKeys key, dynamic value) async {
    await _appBox.put(key.name, value);
  }

  dynamic read(HiveKeys key) => _appBox.get(key.name);

  Future<void> delete(HiveKeys key) async {
    await _appBox.delete(key.name);
  }

  Future<void> clear() async {
    await _appBox.clear();
  }
}
