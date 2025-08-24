import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../cache/preferences_storage/preferences_storage.dart';
import '../cache/preferences_storage/preferences_storage_keys.dart';
import '/core/di/services_locator.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    _initTheme();
  }

  StreamSubscription? _subscription;
  ThemeMode themeMode = ThemeMode.light;

  void _initTheme() {
    final saved = sl<PreferencesStorage>().getString(
      key: PreferencesKeys.themeMode,
    );
    themeMode = saved == 'dark' ? ThemeMode.light : ThemeMode.light;
  }

  void toggleTheme() async {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await sl<PreferencesStorage>().putString(
      key: PreferencesKeys.themeMode,
      value: themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
    emit(ThemeChangedState(themeMode));
  }

  void checkConnection() {
    _subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      if (result.any(
        (e) => e == ConnectivityResult.wifi || e == ConnectivityResult.mobile,
      )) {
        emit(UpdateAppState());
      } else {
        emit(NoInternetState());
      }
    });
  }

  Future<void> changeLanguage({required String language}) async {
    await sl<PreferencesStorage>().putString(
      key: PreferencesKeys.currentLanguage,
      value: language,
    );
    emit(UpdateAppState());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
