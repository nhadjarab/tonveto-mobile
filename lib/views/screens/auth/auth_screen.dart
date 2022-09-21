import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:vet/config/consts.dart';
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
                  APP_NAME,
                  style: TextStyle(fontSize: 10.w, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.divider * 2),
                Lottie.asset('assets/lotties/dog.json'),
                const SizedBox(height: AppTheme.divider * 2),
                CustomButton(
                    text: "Créer un compte",
                    onPressed: () async => await Navigator.pushNamed(
                        context, RegisterScreen.route)),
                const SizedBox(height: AppTheme.divider),
                CustomButton(
                    text: "Se connecter",
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
