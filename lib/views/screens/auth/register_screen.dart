import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../config/theme.dart';
import '../../../utils/validators.dart';
import '../../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_fields.dart';
import '../../widgets/custom_progress.dart';
import '../../widgets/show_message.dart';
import 'info_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const route = "/register";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  String? _email;
  String? _password;

  void nextPage() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final redirect =
          await Provider.of<AuthViewModel>(context, listen: false).register(
        _email,
        _password,
      );
      if (redirect) {
        Navigator.pushReplacementNamed(context, InfoScreen.route,
            arguments: {"email": _email, "password": _password});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Center(
            child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 20, right: 10),
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
                            const Text(
                              'Inscrire',
                              style: TextStyle(
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
                  padding:const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomTextField(
                        preffixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppTheme.mainColor,
                        ),
                        labelText: "e-mail",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => validateEmail(value,
                            "le champ ne peut pas être vide", "email invalide"),
                        onSaved: (value) => _email = value,
                      ),
                      const SizedBox(height: AppTheme.divider),
                      CustomTextField(
                        preffixIcon: const Icon(
                          Icons.lock_outlined,
                          color: AppTheme.mainColor,
                        ),
                        labelText: "Mot de passe",
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
                            "le champ ne peut pas être vide",
                            "Le mot de passe doit contenir au moins un chiffre et +8 caractères"),
                        onSaved: (value) => _password = value,
                      ),
                      const SizedBox(height: AppTheme.divider * 4),
                      Provider.of<AuthViewModel>(context).loading
                          ? const CustomProgress()
                          : CustomButton(
                              width: double.infinity,
                              text: "Inscrire",
                              onPressed: nextPage),
                      const SizedBox(height: AppTheme.divider * 4),
                      Consumer<AuthViewModel>(builder: (context, value, child) {
                        if (value.errorMessage != null) {
                          return ShowMessage(
                              message: value.errorMessage!,
                              isError: true,
                              onPressed: () => value.clearError());
                        }
                        return const SizedBox.shrink();
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      )),
    );
  }
}
