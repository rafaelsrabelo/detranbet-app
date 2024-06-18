import 'package:flutter/material.dart';
import 'package:detranbet/screens/auth_check_screen.dart';
import 'package:detranbet/screens/auth_page.dart';
import 'package:detranbet/main_layout.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const AuthCheckScreen(),
    'auth': (context) => const AuthPage(),
    'main': (context) => const MainLayout(),
  };
}
