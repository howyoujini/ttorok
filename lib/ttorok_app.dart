/*
 * "ttorok" created by @howyoujini on 2/11/24  2:22 PM
 * Copyright (c) . All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ttorok/schemes/color_schemes.dart';
import 'package:ttorok/screen/home.dart';

part 'app_routes.dart';

class TtorokApp extends StatelessWidget {
  static const String _appName = "또록(글또 개발자 커뮤니티 아카이빙)";
  static const String _appFontFamily = "LINESeedKR";

  const TtorokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: _appName,
      routerConfig: _router,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: _appFontFamily,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: _appFontFamily,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}
