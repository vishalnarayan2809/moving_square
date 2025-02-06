import 'package:flutter/material.dart';
import 'package:moving_square/red_square.dart';

void main() {
  runApp(const RedSqaureApp());
}

class RedSqaureApp extends StatelessWidget {
  const RedSqaureApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RedSquare(),
    );
  }
}

