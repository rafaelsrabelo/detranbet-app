import 'package:detranbet/components/button.dart';
import 'package:detranbet/components/loader.dart';
import 'package:detranbet/main.dart';
import 'package:detranbet/models/auth_model.dart';
import 'package:detranbet/providers/dio_provider.dart';
import 'package:detranbet/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

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
                        color: Config.primaryColor,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        color: Config.primaryColor,
                      ),
              ),
            ),
          ),
          Config.spaceSmall,
          Consumer<AuthModel>(builder: (context, auth, child) {
            return Button(
              width: double.infinity,
              title: 'Entrar',
              onPressed: () async {
                Loader.show(); // Mostra o indicador de carregamento

                final token = await DioProvider().getToken(
                  _emailController.text,
                  _passController.text,
                );

                Loader
                    .hide(); // Esconde o indicador de carregamento após a requisição

                if (token != null) {
                  auth.loginSuccess();
                  MyApp.navigatorKey.currentState!.pushNamed('main');
                  MotionToast.success(
                    title: const Text("Login realizado com sucesso!"),
                    description: const Text("Aproveite a sua conta!"),
                  ).show(context);
                } else {
                  MotionToast.error(
                    title: const Text("Login inválido!"),
                    description: const Text("Email ou senha inválido!"),
                  ).show(context);
                }
              },
              disable: false,
            );
          }),
        ],
      ),
    );
  }
}
