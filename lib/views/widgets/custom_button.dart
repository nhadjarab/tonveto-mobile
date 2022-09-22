import 'package:flutter/material.dart';

import '../../config/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;
  final double? width;
   double padding ;
   CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
        this.padding= 14.0 ,
      this.color,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            side: BorderSide.none,
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
          padding:  EdgeInsets.symmetric(vertical: padding, horizontal: padding),
          elevation: 0.0,
          primary: color ?? AppTheme.mainColor,
        ),
        child: Text(text),
      ),
    );
  }
}
