import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tonveto/views/screens/auth/info_screen.dart';

import '../../../config/theme.dart';
import '../../../utils/validators.dart';
import '../../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_fields.dart';
import '../../widgets/custom_progress.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const route = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  String? _email;

  String? _password;

  bool loading = false;

  void login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final userComplete =
          await Provider.of<AuthViewModel>(context, listen: false).login(
        _email,
        _password,
      );
       if (!mounted) return;

        if (userComplete) {
          // ignore: use_build_context_synchronously

          await Navigator.pushReplacementNamed(context, InfoScreen.route,
              arguments: {"email": _email, "password": _password});
          // ignore: use_build_context_synchronously
        } else if (Provider.of<AuthViewModel>(context, listen: false).isAuth) {
          // ignore: use_build_context_synchronously


          Navigator.pop(context);
        }

    }
  }

  @override
  Widget build(BuildContext context) {
    final textLocals = AppLocalizations.of(context)!;

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Center(
        child: Form(
          key: _formKey,
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            textLocals.seConnecter,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.divider * 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomTextField(
                      preffixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppTheme.mainColor,
                      ),
                      labelText: textLocals.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => validateEmail(
                          value,
                          textLocals.leChampNePeutPasEtreVide,
                          textLocals.emailInvalide),
                      onSaved: (value) => _email = value,
                    ),
                    const SizedBox(height: AppTheme.divider),
                    CustomTextField(
                      labelText: textLocals.motDePasse,
                      preffixIcon: const Icon(
                        Icons.lock_outlined,
                        color: AppTheme.mainColor,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_passwordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppTheme.mainColor,
                        ),
                        onPressed: () => setState(
                            () => _passwordVisible = !_passwordVisible),
                      ),
                      validator: (value) => validatePassword(
                          value,
                          textLocals.leChampNePeutPasEtreVide,
                          textLocals
                              .leMotDePasseDoitContenirAumoinsunChiffreEtAvoirAuMoinsCaracteres),
                      onSaved: (value) => _password = value,
                    ),
                    const SizedBox(height: AppTheme.divider * 4),
                    Provider.of<AuthViewModel>(context).loading
                        ? const CustomProgress()
                        : CustomButton(
                            width: double.infinity,
                            text: textLocals.seConnecter,
                            onPressed: login),
                    Consumer<AuthViewModel>(builder: (context, value, child) {
                      if (value.errorMessage != null) {
                        Future.delayed(Duration.zero, () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(value.errorMessage!),
                            backgroundColor: AppTheme.errorColor,
                          ));
                          value.clearError();
                        });
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
