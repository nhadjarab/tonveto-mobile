import 'package:flutter/material.dart';
import 'package:vet/config/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;
  final double? width;
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
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
              Radius.circular(3),
            ),
            side: BorderSide.none,
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.normal),
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
          elevation: 0.0,
          primary: color ?? AppTheme.mainColor,
        ),
        child: Text(text),
      ),
    );
  }
}
