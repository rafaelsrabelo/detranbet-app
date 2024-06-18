import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:detranbet/screens/auth_page.dart';
import 'package:detranbet/main_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({Key? key}) : super(key: key);

  @override
  _AuthCheckScreenState createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  Future<void> _loadFirstScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      _navigateToRoute('auth');
    } else {
      _navigateToRoute('main');
    }
  }

  void _navigateToRoute(String routeName) {
    // Use a small delay to ensure the current widget build is completed
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushReplacementNamed(routeName);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFirstScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Use a CircularProgressIndicator here
      ),
    );
  }
}
