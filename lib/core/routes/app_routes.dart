import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:what_s_up_app/core/env.dart';
import 'route_observer.dart';
import 'route_paths.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

final CustomGoRouterObserver customGoRouterObserver = CustomGoRouterObserver();

final routes = GoRouter(
  initialLocation: Routes.splashScreen,
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  observers: [
    if (isDevEnvironment()) ChuckerFlutter.navigatorObserver,
    SentryNavigatorObserver(),
  ],
  routes: [
    // GoRoute(path: Routes.splashScreen, builder: (_, __) => SplashScreen()),

  ],
);
