import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vet/config/theme.dart';
import 'package:vet/views/screens/auth/login_screen.dart';
import 'package:vet/views/screens/auth/register_screen.dart';
import 'package:vet/views/widgets/custom_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 90.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: AppTheme.divider),
                Text(
                  "tonveto",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.divider * 2),
                CustomButton(
                    text: "Créer un compte",
                    onPressed: () async => await Navigator.pushNamed(
                        context, RegisterScreen.route)),
                const SizedBox(height: AppTheme.divider),
                TextButton(
                    child: const Text("Se connecter"),
                    onPressed: () async =>
                        await Navigator.pushNamed(context, LoginScreen.route)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
