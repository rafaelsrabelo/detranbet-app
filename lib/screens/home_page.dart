import 'package:detranbet/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'User';
  String userEmail = 'example@email.com';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
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

  String getInitials(String name) {
    List<String> names = name.split(' ');
    String initials = '';
    if (names.isNotEmpty) initials += names[0][0];
    if (names.length > 1) initials += names[1][0];
    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        userEmail,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Config.primaryColor,
                    child: Text(
                      getInitials(userName),
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Config.backgroundColor,
                      ),
                    ),
                  )
                ],
              ),
              Config.spaceSmall,
              Text(
                'Ligas',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Config.spaceSmall,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Config.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text('Campeonato Brasileiro', 
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
