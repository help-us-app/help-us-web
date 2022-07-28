import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:help_us_web/pages/wrapper/wrapper.dart';
import 'package:help_us_web/utils/app_themes.dart';
import 'package:help_us_web/utils/route_generator.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'help-us web',
      themeMode: ThemeMode.dark,
      darkTheme: AppThemes.dark,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
