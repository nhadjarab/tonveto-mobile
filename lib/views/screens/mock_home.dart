import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vet/viewmodels/auth_viewmodel.dart';
import 'package:vet/views/widgets/custom_button.dart';

class MockHome extends StatelessWidget {
  const MockHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CustomButton(
        text: "Logout",
        onPressed: () async {
          await Provider.of<AuthViewModel>(context, listen: false).logout();
        },
      ),
    ));
  }
}
