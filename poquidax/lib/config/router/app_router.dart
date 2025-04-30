import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedax/config/router/routes_list.dart';
import 'package:pokedax/providers/user_provider.dart';
import 'package:pokedax/services/navigation_service.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  routes: routesList,
  initialLocation: '/login',
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    final container = ProviderScope.containerOf(context);
    final userNotifier = container.read(userProvider.notifier);

    // Wait for the initialization to complete
    await userNotifier.initializationFuture;

    final uuid = container.read(userProvider).uuid;

    // If the UUID is loaded, redirect to "/"
    if (uuid.isNotEmpty && state.uri.toString() == '/login') {
      return '/';
    }

    // If no UUID, stay on "/login"
    return null;
  },
);