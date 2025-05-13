import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedax/view/pokedex/pokedex_template.dart';
import 'package:pokedax/view/session/login_view.dart';
import 'package:pokedax/view/session/signup_view.dart';

final List<RouteBase> routesList = [
  GoRoute(
    path: '/',
    name: 'home',
    builder: (BuildContext context, GoRouterState state)  => PokedexTemplate(),
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
