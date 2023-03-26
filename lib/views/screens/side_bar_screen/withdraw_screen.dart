import 'package:flutter/material.dart';

class WithdrawScreen extends StatelessWidget {
  static const String routeName = '\WithdrawScreen';

  Widget _rowHeader(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade700,
          ),
          color: Colors.yellow.shade900,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Withdraw",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              _rowHeader("NAME", 1),
              _rowHeader("AMOUNT", 3),
              _rowHeader("BANK NAME", 2),
              _rowHeader("BANK ACCOUNT", 2),
              _rowHeader("EMAIL", 1),
              _rowHeader("PHONE", 1),
            ],
          )
        ],
      ),
    );
  }
}
