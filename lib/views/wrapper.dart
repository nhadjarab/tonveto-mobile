import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';
import 'package:tonveto/views/screens/auth/auth_screen.dart';
import 'package:tonveto/views/screens/main_screen.dart';

import '../config/theme.dart';
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
                return OfflineBuilder(
                    connectivityBuilder: (
                      BuildContext context,
                      ConnectivityResult connectivity,
                      Widget child,
                    ) {
                      final bool connected =
                          connectivity != ConnectivityResult.none;
                      WidgetsBinding.instance.addPostFrameCallback((_){

                        // Add Your Code here.
                        if(!connected){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const  SnackBar(
                              content: Text(
                                'Vous étes hors ligne',
                                style:
                                TextStyle(color: Colors.white),
                              ),
                              backgroundColor: AppTheme.errorColor,
                              duration: Duration(days: 1),
                            ),
                          );
                        }else{
                          Future.delayed(const Duration(seconds: 5),(){
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();

                          });
                        }
                      });

                      return child;
                    },
                    child: const MainScreen());
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
