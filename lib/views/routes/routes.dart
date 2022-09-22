import 'package:flutter/material.dart';


import '../screens/auth/info_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home.dart';
import '../screens/profile/edit_profile_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../wrapper.dart';

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
