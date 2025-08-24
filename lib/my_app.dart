
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:what_s_up_app/core/app_cubit/app_cubit.dart';
import 'package:what_s_up_app/core/app_cubit/app_state.dart';
import 'package:what_s_up_app/core/cache/preferences_storage/preferences_storage.dart';
import 'package:what_s_up_app/core/di/services_locator.dart';
import 'package:what_s_up_app/core/routes/app_routes.dart';
import 'package:what_s_up_app/core/theme/dark_theme.dart';
import 'package:what_s_up_app/core/theme/light_theme.dart';
import 'package:what_s_up_app/generated/l10n.dart';

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: providers,
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final cubit = context.read<AppCubit>();
              return MaterialApp.router(
                key: ValueKey(sl<PreferencesStorage>().getCurrentLanguage()),
                title: 'What\'s App',
                routerConfig: routes,
                debugShowCheckedModeBanner: false,
                themeMode: cubit.themeMode,
                darkTheme: darkTheme,
                theme: lightTheme,
                //locale: Locale(sl<PreferencesStorage>().getCurrentLanguage()),
                supportedLocales: S.delegate.supportedLocales,
                localizationsDelegates:  [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
              );
            },
          ),
        );
      },
    );
  }

  final providers = [
    BlocProvider<AppCubit>(create: (context) => AppCubit()..checkConnection()),
 
  ];

  final supportedLocales = const [ Locale('en'),Locale('ar')];
}