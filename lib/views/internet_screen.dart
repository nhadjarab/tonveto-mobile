import 'package:flutter/material.dart';
import 'package:tonveto/views/widgets/custom_button.dart';
import 'package:tonveto/views/wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InternetScreen extends StatelessWidget {
  const InternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textLocals = AppLocalizations.of(context)!;

    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(textLocals.pasDeConnexionInternet,style: const TextStyle(fontSize: 22),),
            const SizedBox(height: 40,),
            CustomButton(text: textLocals.reconnecter, onPressed: (){
              Navigator.pushReplacementNamed(context, Wrapper.route);
            })
          ],
        ),
      ),
    );
  }
}
