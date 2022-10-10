import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/views/screens/auth/register_screen.dart';

import '../../../config/consts.dart';
import '../../../config/theme.dart';
import '../../widgets/custom_button.dart';
import 'login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textLocals = AppLocalizations.of(context)!;

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
                    appName,
                    style: TextStyle(
                        fontSize: 10.w,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: AppTheme.divider * 2),
                    Lottie.asset('assets/lotties/dog.json',height: 40.h),
                    const SizedBox(height: AppTheme.divider * 2),
                    CustomButton(
                        text: textLocals.creerUnCompte,
                        width: double.infinity,
                        onPressed: () async => await Navigator.pushNamed(
                            context, RegisterScreen.route)),
                    const SizedBox(height: AppTheme.divider),
                    CustomButton(
                        text: textLocals.seConnecter,
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
