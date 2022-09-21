import 'package:flutter/material.dart';
import 'package:vet/views/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vet',
      routes: Routes.routes,
      initialRoute: "/",
    );
  }
}
