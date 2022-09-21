import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:vet/config/theme.dart';
import 'package:vet/utils/validators.dart';
import 'package:vet/viewmodels/auth_viewmodel.dart';
import 'package:vet/views/screens/auth/register_screen.dart';
import 'package:vet/views/widgets/custom_button.dart';
import 'package:vet/views/widgets/custom_fields.dart';
import 'package:vet/views/widgets/custom_progress.dart';
import 'package:vet/views/widgets/show_message.dart';

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

      await Provider.of<AuthViewModel>(context, listen: false).login(
        _email,
        _password,
      );
      if (Provider.of<AuthViewModel>(context, listen: false).isAuth) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Se connecter"),
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
                    validator: (value) => validateEmail(value,
                        "le champ ne peut pas être vide", "email invalide"),
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
                    validator: (value) => validatePassword(
                        value,
                        "le champ ne peut pas être vide",
                        "Le mot de passe doit contenir au moins un chiffre et +8 caractères"),
                    onSaved: (value) => _password = value,
                  ),
                  const SizedBox(height: AppTheme.divider * 4),
                  Provider.of<AuthViewModel>(context).loading
                      ? const CustomProgress()
                      : CustomButton(text: "Se connecter", onPressed: login),
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
          )),
        ));
  }
}
