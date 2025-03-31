import 'package:go_router/go_router.dart';
import 'package:pokedax/config/router/routes_list.dart';
import 'package:pokedax/services/navigation_service.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  routes: routesList,
  initialLocation: '/login',
  debugLogDiagnostics: true,
);