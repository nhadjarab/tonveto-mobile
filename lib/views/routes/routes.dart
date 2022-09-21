import 'package:flutter/material.dart';
import 'package:vet/views/screens/home.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    Home.route: (_) => const Home(),
  };
}
