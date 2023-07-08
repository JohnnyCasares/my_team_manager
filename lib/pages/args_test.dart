import 'package:flutter/material.dart';

class ArgTest extends StatelessWidget {
  const ArgTest({super.key, required this.dataTest});

  final String dataTest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dataTest),),
      body: Text(dataTest),
    );
  }
}
