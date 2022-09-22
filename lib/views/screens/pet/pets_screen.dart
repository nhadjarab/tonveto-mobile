import 'package:flutter/material.dart';

class PetsScreen extends StatelessWidget {
  static const route = "/pets";
  const PetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ListTile(),
      ),
    );
  }
}
