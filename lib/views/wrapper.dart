import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vet/utils/internet_check.dart';
import 'package:vet/viewmodels/auth_viewmodel.dart';
import 'package:vet/views/internet_screen.dart';
import 'package:vet/views/loading_screen.dart';
import 'package:vet/views/screens/auth/auth_screen.dart';
import 'package:vet/views/screens/auth/login_screen.dart';
import 'package:vet/views/screens/home.dart';
import 'package:vet/views/screens/mock_home.dart';

class Wrapper extends StatelessWidget {
  static const route = "/";

  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkUserConnection,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingScreen();
          }
          final bool isConnected = snapshot.data as bool;
          if (!isConnected) {
            return const InternetScreen();
          } else {
            return Consumer<AuthViewModel>(builder: (context, auth, _) {
              if (auth.isAuth) {
                return const Home();
              } else {
                return FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) return const AuthScreen();
                      return const LoadingScreen();
                    });
              }
            });
          }
        });
  }
}
