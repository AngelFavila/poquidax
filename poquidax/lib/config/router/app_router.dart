
import 'package:go_router/go_router.dart';
import 'package:pokedax/config/router/routes_list.dart';
import 'package:pokedax/services/navigation_service.dart';
import 'package:pokedax/services/preferences_service.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  routes: routesList,
  initialLocation: '/login',
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    final uuid = await PreferencesService().uuid;

    // If the UUID is loaded, redirect to "/"
    if (uuid.isNotEmpty && state.uri.toString() == '/login') {
      return '/';
    }

    // If no UUID, stay on "/login"
    return null;
  },
);