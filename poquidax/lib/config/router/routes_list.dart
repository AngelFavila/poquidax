import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_template.dart';
import 'package:pokedax/view/pokedex/pokedex_view.dart';
import 'package:pokedax/view/selector/selector_view.dart';
import 'package:pokedax/view/session/login_view.dart';
import 'package:pokedax/view/session/signup_view.dart';
import 'package:pokedax/viewmodel/catch_selector_viewmodel.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

final List<RouteBase> routesList = [
  GoRoute(
    path: '/',
    name: 'home',
    builder: (BuildContext context, GoRouterState state) {
      return Consumer<PokedexProvider>(
        builder: (context, pokedexProvider, child) {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   context.read<PokedexProvider>().changeModel(HomeViewModel());
          // });

          return PokedexTemplate();
        },
      );
    },
  ),
  GoRoute(
    path: '/login',
    name: 'login',
    builder: (BuildContext context, GoRouterState state) => LoginView(),
  ),
  GoRoute(
    path: '/signup',
    name: 'signup',
    builder: (BuildContext context, GoRouterState state) => SignUpView(),
  ),
  GoRoute(
    path: '/selector',
    name: 'selector',
    builder: (BuildContext context, GoRouterState state) => SelectorView(),
  ),
  GoRoute(
    path: '/catch',
    name: 'catch',
    builder: (BuildContext context, GoRouterState state) {
      final String? numberString = state.uri.queryParameters['number'];
      final int? number =
          numberString != null ? int.tryParse(numberString) : null;

      return PokedexView();
    },
  ),
  GoRoute(
    path: '/catch_selector',
    name: 'catch_selector',
    builder: (BuildContext context, GoRouterState state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<PokedexProvider>().changeModel(CatchSelectorViewModel());
      });

      return PokedexView();
    },
  ),
];
