import 'package:detranbet/components/login_form.dart';
import 'package:detranbet/utils/config.dart';
import 'package:detranbet/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(
                AppText.ptBrText['welcome_text']!,
                style: GoogleFonts.inter(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              Text(
                AppText.ptBrText['signIn_text']!,
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
              Config.spaceSmall,
              const LoginForm(),
              Config.spaceMedium,
              Center(
                child: Text(AppText.ptBrText['registered_text']!,
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              )
            ])),
      ),
    );
  }
}
