import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_app/routes/Home/home_screen.dart';
import 'package:wallet_app/routes/Login/login_screen.dart';
import 'package:wallet_app/routes/Widgets/num_keyboard_widget.dart';

class EnterPIN extends StatefulWidget {
  const EnterPIN({Key? key}) : super(key: key);

  @override
  _EnterPINState createState() => _EnterPINState();
}

class _EnterPINState extends State<EnterPIN> {
  String _password = "", uid = '';

  void addString(String index) {
    setState(() {
      if (_password.length < 4) _password += index.toString();
      if (_password.length == 4) {
        CheckPin();
      }
    });
  }

  void removeString() {
    setState(() {
      if (_password.length > 0)
        _password = _password.substring(0, _password.length - 1);
    });
  }

  Future<void> CheckPin() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    if (uid != '') {
      await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
        (DocumentSnapshot documentSnapshot) async {
          if (documentSnapshot.exists) {
            if (Crypt.sha256(_password, rounds: 10000, salt: 'viiducc').hash ==
                documentSnapshot.get('pin'))
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            else {
              await FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            }
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verification Required',
          style: TextStyle(
              color: Color(0xFF0D1F3C),
              fontSize: 26,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFEDF1F9),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            height: 24,
            width: 24,
          ),
        ),
      ),
      backgroundColor: Color(0xFFEDF1F9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Please enter your PIN to proceed',
            style: TextStyle(fontSize: 15),
          ),
          // const SizedBox(
          //   height: 149,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 4; i++)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < _password.length
                          ? Color(0xFF75BF72)
                          : Color(0xFF9EA5B1),
                    ),
                  ),
                )
            ],
          ),
          NumKeyBoard(
            removeString: removeString,
            pressAddString: addString,
          )
        ],
      ),
    );
  }
}
