import 'package:flutter/material.dart';
import 'package:vet/config/theme.dart';

class CustomProgress extends StatelessWidget {
  final double? size;
  const CustomProgress({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppTheme.mainColor,
        ),
      ),
    );
  }
}
