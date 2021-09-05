import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:wallet_app/routes/Home/home_screen.dart';
import 'package:wallet_app/routes/OnBoard/onboard_screen.dart';

void main() async {
  // await FlutterIconNetwork.instance!
  //     .init(host: "https://bicon.net.solidwallet.io/api/v3", isTestNet: true);
  // await Firebase.initializeApp();
  // await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //   email: 'viduct2000@gmail.com',
  //   password: '23112000',
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'TitilliumWeb'),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
