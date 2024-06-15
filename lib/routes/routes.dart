import 'package:detranbet/main_layout.dart';
import 'package:detranbet/screens/auth_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const AuthPage(),
    'main': (context) => const MainLayout(),
  };
}
