import 'package:detranbet/components/button.dart';
import 'package:detranbet/providers/dio_provider.dart';
import 'package:detranbet/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
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
            controller: _nameController,
            keyboardType: TextInputType.name,
            cursorColor: Config.primaryColor,
            style: GoogleFonts.inter(
              color: Config.primaryColor,
            ),
            decoration: const InputDecoration(
              hintText: 'Name',
              labelText: 'Nome',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outline),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
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
                      ),
              ),
            ),
          ),
          Config.spaceSmall,
          Button(
            width: double.infinity,
            title: 'Registrar',
            onPressed: () async {
              bool success = await DioProvider().createUser(
                _emailController.text,
                _nameController.text,
                _passController.text,
              );

              if (success) {
                // Redirecionar para a página de login ou mostrar uma mensagem de sucesso
                print('Conta criada com sucesso');
              } else {
                // Mostrar mensagem de erro
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Erro ao criar conta')),
                );
              }
            },
            disable: false,
          ),
        ],
      ),
    );
  }
}
