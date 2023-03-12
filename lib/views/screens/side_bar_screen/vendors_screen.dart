import 'package:flutter/material.dart';

class VendorsScreen extends StatelessWidget {
  static const String routeName = '\VendorsScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: const Text(
          "Vendors",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}
