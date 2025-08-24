import 'package:flutter/material.dart';
import 'package:what_s_up_app/core/helpers/safe_print.dart';

class CustomGoRouterObserver extends NavigatorObserver {
  String? previousRoute;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      this.previousRoute = route.settings.name;
      safePrint("Returned to: ${route.settings.name}");
    }
  }
}
