import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tonveto/views/widgets/custom_button.dart';
import 'package:tonveto/views/wrapper.dart';

class InternetScreen extends StatelessWidget {
  const InternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No internet connection",style: TextStyle(fontSize: 22),),
            SizedBox(height: 40,),
            CustomButton(text: 'Reconnecter', onPressed: (){
              Navigator.pushReplacementNamed(context, Wrapper.route);
            })
          ],
        ),
      ),
    );
  }
}
