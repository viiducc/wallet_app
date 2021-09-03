import 'package:flutter/material.dart';
import 'package:wallet_app/routes/Home/home_screen.dart';
import 'package:wallet_app/routes/OnBoard/onboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'TitilliumWeb'),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
