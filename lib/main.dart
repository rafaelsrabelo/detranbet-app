import 'package:asuka/asuka.dart';
import 'package:detranbet/models/auth_model.dart';
import 'package:detranbet/routes/routes.dart';
import 'package:detranbet/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:asuka/asuka.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthModel>(
      create: (context) => AuthModel(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'detranbet',
        debugShowCheckedModeBanner: false,
        builder: Asuka.builder,
        navigatorObservers: [
          Asuka
              .asukaHeroController //This line is needed for the Hero widget to work
        ],
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
      ),
    );
  }
}
