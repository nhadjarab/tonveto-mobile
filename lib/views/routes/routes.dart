import 'package:flutter/material.dart';
import 'package:vet/views/screens/auth/info_screen.dart';
import 'package:vet/views/screens/auth/login_screen.dart';
import 'package:vet/views/screens/auth/register_screen.dart';
import 'package:vet/views/screens/profile/edit_profile_screen.dart';
import 'package:vet/views/screens/profile/profile_screen.dart';
import 'package:vet/views/wrapper.dart';

import '../screens/home.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    Wrapper.route: (_) => const Wrapper(),
    LoginScreen.route: (_) => const LoginScreen(),
    RegisterScreen.route: (_) => const RegisterScreen(),
    InfoScreen.route: (_) => const InfoScreen(),
    Home.route: (_) => const Home(),
    ProfileScreen.route: (_) => const ProfileScreen(),
    EditProfileScreen.route: (_) => const EditProfileScreen(),
  };
}
