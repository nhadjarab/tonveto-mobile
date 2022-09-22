import 'package:flutter/material.dart';

import '../../config/theme.dart';

class ShowMessage extends StatelessWidget {
  final String message;
  final bool isError;
  final void Function()? onPressed;

  const ShowMessage({
    Key? key,
    required this.message,
    required this.isError,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: AppTheme.divider),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: isError ? AppTheme.errorColor : AppTheme.successColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            )),
            IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ))
          ],
        ));
  }
}
