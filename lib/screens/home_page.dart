import 'package:detranbet/components/app_header.dart';
import 'package:detranbet/components/card_leagues.dart';
import 'package:detranbet/providers/dio_provider.dart';
import 'package:detranbet/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:detranbet/models/league.dart'; // Importe o modelo League

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String userName = 'User';
  String userEmail = 'example@email.com';
  List<League> leagues = [];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _fetchLeagues();
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');

    setState(() {
      userName = name ?? 'User';
      userEmail = email ?? 'example@email.com';
    });
  }

  Future<void> _fetchLeagues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      List<League> fetchedLeagues = await DioProvider().getLeagues(token);

      setState(() {
        leagues = fetchedLeagues;
      });
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      await DioProvider().logout(token);
      Navigator.pushNamedAndRemoveUntil(
          context, '/', (route) => false); // Navega para a tela de login
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Config.backgroundColor,
          title: const Text(
            'Confirmação de Logout',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Você tem certeza que deseja sair?',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o modal
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Fecha o modal
                await _logout(); // Chama a função de logout
              },
              child: Text(
                'Sair',
                style: GoogleFonts.inter(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Config.backgroundColor,
        child: Column(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Config.backgroundColor,
              ),
              child: Text(
                'DetranBet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.white),
                    title: Text('Inicio',
                        style: GoogleFonts.inter(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.white),
                    title: Text('Configurações',
                        style: GoogleFonts.inter(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Sair', style: TextStyle(color: Colors.red)),
                onTap: _showLogoutConfirmationDialog,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Config.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeader(
                userName: userName,
                userEmail: userEmail,
                onAvatarTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Ligas',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              leagues.isNotEmpty
                  ? Expanded(child: CardLeagues(leagues: leagues))
                  : const Center(
                      child: CircularProgressIndicator(
                      color: Config.primaryColor,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
