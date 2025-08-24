import 'dart:io';

import 'package:safe_device/safe_device.dart';

class SecurityViolationUtil {
  static Future<bool> isAndroidDeveloperModeEnabld() async {
    if (!Platform.isAndroid) return false;

    bool isDevelopmentModeEnable = await SafeDevice.isDevelopmentModeEnable;

    if (isDevelopmentModeEnable) {
      return true;
    }
    return false;
  }
}
