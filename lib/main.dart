import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wallet_app/routes/Home/home_screen.dart';
import 'package:wallet_app/routes/OnBoard/onboard_screen.dart';

User? currentUser = FirebaseAuth.instance.currentUser;

void main() async {
  await GetStorage.init();
  await FlutterIconNetwork.instance!
      .init(host: "https://bicon.net.solidwallet.io/api/v3", isTestNet: true);
  // runApp(MyApp());
  // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print(currentUser);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'TitilliumWeb'),
      debugShowCheckedModeBanner: false,
      home: currentUser == null ? OnBoard() : Home(),
    );
  }
}
