import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_s_up_app/core/cache/secure_storage/secure_storage.dart';
import 'package:what_s_up_app/core/di/services_locator.dart';
import 'package:what_s_up_app/core/helpers/app_bloc_observer.dart';
import 'package:what_s_up_app/core/helpers/safe_print.dart';
import 'package:what_s_up_app/core/helpers/user_helpers.dart';
import 'package:what_s_up_app/my_app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesLocator().init();
  Bloc.observer = AppBlocObserver();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  safePrint(UserHelpers.isFirstTime());
  final token = await sl<SecureStorage>().read(SecureStorageKeys.userToken);
  safePrint("token ===> $token");
  runApp(MyApp());
}

