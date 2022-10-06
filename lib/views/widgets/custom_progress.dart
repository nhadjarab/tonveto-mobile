import 'package:flutter/material.dart';

import '../../config/theme.dart';

class CustomProgress extends StatelessWidget {
  final double? size;
  final Color? color;
  const CustomProgress({Key? key,this.color = AppTheme.mainColor, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child:  Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
