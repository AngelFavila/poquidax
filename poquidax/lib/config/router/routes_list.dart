import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedax/view/pokedex/pokedex_template.dart';
import 'package:pokedax/view/session/login_view.dart';
import 'package:pokedax/view/session/signup_view.dart';
import 'package:pokedax/viewmodel/session/login_viewmodel.dart';
import 'package:pokedax/viewmodel/session/signup_viewModel.dart';
import 'package:provider/provider.dart';

final List<RouteBase> routesList = [
  GoRoute(
    path: '/',
    name: 'home',
    builder: (BuildContext context, GoRouterState state) => PokedexTemplate(),
  ),
  GoRoute(
    path: '/login',
    name: 'login',
    builder: (BuildContext context, GoRouterState state) =>
        ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: LoginView(),
    ),
  ),
  GoRoute(
    path: '/signup',
    name: 'signup',
    builder: (BuildContext context, GoRouterState state) =>
        ChangeNotifierProvider(
      create: (_) => SignUpViewModel(),
      child: SignUpView(),
    ),
  ),
  GoRoute(
    path: '/selector',
    name: 'selector',
    builder: (BuildContext context, GoRouterState state) => PokedexTemplate(),
  ),
  GoRoute(
    path: '/catch',
    name: 'catch',
    builder: (BuildContext context, GoRouterState state) => PokedexTemplate(),
  ),
  GoRoute(
    path: '/catch_selector',
    name: 'catch_selector',
    builder: (BuildContext context, GoRouterState state) => PokedexTemplate(),
  ),
  GoRoute(
    path: '/pokemon',
    name: 'pokemon',
    builder: (BuildContext context, GoRouterState state) => PokedexTemplate(),
  ),
];
