// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';

class Observer extends RouteObserver<PageRoute<dynamic>>
    with WidgetsBindingObserver {
  Observer() {
    WidgetsBinding.instance.addObserver(this);
  }

  /// Defined for batch delete on return to foreground on iOS
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}