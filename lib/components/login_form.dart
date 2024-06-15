import 'package:detranbet/components/button.dart';
import 'package:detranbet/utils/config.dart';
import 'package:detranbet/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obscurePass = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Config.primaryColor,
              style: GoogleFonts.inter(
                color: Config.primaryColor,
              ),
              decoration: const InputDecoration(
                hintText: 'Email Address',
                labelText: 'Email',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.email_outlined),
                prefixIconColor: Config.primaryColor,
              ),
            ),
            Config.spaceSmall,
            TextFormField(
              controller: _passController,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Config.primaryColor,
              obscureText: obscurePass,
              style: GoogleFonts.inter(
                color: Config.primaryColor,
              ),
              decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Senha',
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  prefixIconColor: Config.primaryColor,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePass = !obscurePass;
                        });
                      },
                      icon: obscurePass
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black38,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              color: Config.primaryColor,
                            ))),
            ),
            Config.spaceSmall,
            Button(
                width: double.infinity,
                title: 'Entrar',
                onPressed: () {},
                disable: false),
            // Config.spaceSmall,
          ],
        ));
  }
}
