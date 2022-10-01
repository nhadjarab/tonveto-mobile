import 'package:flutter/material.dart';
import 'package:tonveto/views/widgets/custom_button.dart';
import 'package:tonveto/views/wrapper.dart';

class InternetScreen extends StatelessWidget {
  const InternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textLocals.pasDeConnexionInternet,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
                text: 'Reconnecter',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Wrapper.route);
                })
          ],
        ),
      ),
    );
  }
}
