import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void push(String route) {
    navigatorKey.currentContext?.push(route);
  }

  static void go(String route) {
    navigatorKey.currentContext?.go(route);
  }

  static void pop() {
    navigatorKey.currentContext?.pop();
  }
}
