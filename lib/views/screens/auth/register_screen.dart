import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vet/config/theme.dart';
import 'package:vet/views/screens/auth/info_screen.dart';
import 'package:vet/views/widgets/custom_button.dart';
import 'package:vet/views/widgets/custom_fields.dart';

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

  void nextPage() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushNamed(context, InfoScreen.route,
          arguments: {"email": _email, "password": _password});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Créer un compte"),
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppTheme.divider * 2),
                  CustomTextField(
                    labelText: "e-mail",
                    keyboardType: TextInputType.emailAddress,
                    // validator: (value) => validateEmail(value,
                    //     "le champ ne peut pas être vide", "email invalide"),
                    onSaved: (value) => _email = value,
                  ),
                  const SizedBox(height: AppTheme.divider),
                  CustomTextField(
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
                      onPressed: () =>
                          setState(() => _passwordVisible = !_passwordVisible),
                    ),
                    // validator: (value) => validatePassword(
                    //     value,
                    //     "le champ ne peut pas être vide",
                    //     "Le mot de passe doit contenir au moins un chiffre et +8 caractères"),
                    onSaved: (value) => _password = value,
                  ),
                  const SizedBox(height: AppTheme.divider * 4),
                  CustomButton(text: "Suivant", onPressed: nextPage),
                ],
              ),
            ),
          )),
        ));
  }
}
