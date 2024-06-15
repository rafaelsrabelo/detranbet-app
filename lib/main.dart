import 'package:detranbet/routes/routes.dart';
import 'package:detranbet/utils/config.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'detranbet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.white),
              focusColor: Config.primaryColor,
              border: Config.outlinedBorder,
              focusedBorder: Config.focusBorder,
              errorBorder: Config.errorBorder,
              enabledBorder: Config.outlinedBorder,
              floatingLabelStyle: TextStyle(
                color: Config.primaryColor,
              ),
              prefixIconColor: Colors.black38),
          scaffoldBackgroundColor: Config.primaryColor.withOpacity(0.1),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Config.primaryColor,
              selectedItemColor: Colors.white,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.grey,
              elevation: 10,
              type: BottomNavigationBarType.fixed)),
      initialRoute: '/',
      routes: Routes.routes,
    );
  }
}
