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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppTheme.mainColor,
                  ),
                  child: Text(
                    APP_NAME,
                    style: TextStyle(
                        fontSize: 10.w,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: AppTheme.divider * 2),
                    Lottie.asset('assets/lotties/dog.json',height: 40.h),
                    const SizedBox(height: AppTheme.divider * 2),
                    CustomButton(
                        text: "Créer un compte",
                        width: double.infinity,
                        onPressed: () async => await Navigator.pushNamed(
                            context, RegisterScreen.route)),
                    const SizedBox(height: AppTheme.divider),
                    CustomButton(
                        text: "Se connecter",
                        width: double.infinity,
                        onPressed: () async => await Navigator.pushNamed(
                            context, LoginScreen.route)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
