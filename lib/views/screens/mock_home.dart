import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vet/viewmodels/auth_viewmodel.dart';
import 'package:vet/views/widgets/custom_button.dart';

class MockHome extends StatefulWidget {
  const MockHome({Key? key}) : super(key: key);

  @override
  State<MockHome> createState() => _MockHomeState();
}

class _MockHomeState extends State<MockHome> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AuthViewModel>(context, listen: false).getUserData();
    });
  }

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
