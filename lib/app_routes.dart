/*
 * "ttorok" created by @howyoujini on 2/11/24  2:30 PM
 * Copyright (c) . All rights reserved.
 */

part of '../ttorok_app.dart';

const _pathLogin = "/login";
const _pathHome = "/";
const _pathUser = "/user";

enum AppRoutes {
  LOGIN(_pathLogin),
  HOME(_pathHome),
  MY(_pathUser);

  final String path;

  const AppRoutes(this.path);
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.HOME.path,
      name: AppRoutes.HOME.name,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
