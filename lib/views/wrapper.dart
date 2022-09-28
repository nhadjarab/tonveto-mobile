import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tonveto/views/screens/auth/auth_screen.dart';
import 'package:tonveto/views/screens/main_screen.dart';

import '../utils/internet_check.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'internet_screen.dart';
import 'loading_screen.dart';


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
                return const MainScreen();
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
