import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tonveto/views/screens/profile/profile_screen.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    final textLocals = AppLocalizations.of(context)!;

    return Scaffold(
        body: Center(
      child: CustomButton(
        text: textLocals.profile,
        onPressed: () async {

          Navigator.pushNamed(context, ProfileScreen.route);
        },
      ),
    ));
  }
}
