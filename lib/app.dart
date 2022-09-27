import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/viewmodels/auth_viewmodel.dart';
import 'package:tonveto/viewmodels/payement_viewmodel.dart';
import 'package:tonveto/viewmodels/search_viewmodel.dart';
import 'package:tonveto/views/routes/routes.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthViewModel>(
              create: (context) => AuthViewModel()),
          ChangeNotifierProvider<SearchViewModel>(
              create: (context) => SearchViewModel()),
          ChangeNotifierProvider<PayementViewModel>(
              create: (context) => PayementViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vet',
          routes: Routes.routes,
          initialRoute: "/",
        ),
      );
    });
  }
}
