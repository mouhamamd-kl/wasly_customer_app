import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteObserver2 extends NavigatorObserver {
  static final List<String> routeHistory = <String>[];

  @override
  RouteSettings? redirect(String? route) {
    routeHistory.add(route ?? '');
    return null;
  }

  static void printRouteHistory() {
    print('Route History: ${routeHistory.join(' -> ')}');
  }

  static String getPreviousRoute() {
    return routeHistory.length > 1 ? routeHistory[routeHistory.length - 2] : '';
  }

  static void clearHistory() {
    routeHistory.clear();
  }
}
