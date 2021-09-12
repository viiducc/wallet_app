import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_app/routes/ConfirmPIN/confirm_pin_screen.dart';
import 'package:wallet_app/routes/Home/home_screen.dart';
import 'package:wallet_app/routes/OnBoard/onboard_screen.dart';
import 'package:wallet_app/routes/Widgets/num_keyboard_widget.dart';

class CreatePIN extends StatefulWidget {
  const CreatePIN({Key? key}) : super(key: key);

  @override
  _CreatePINState createState() => _CreatePINState();
}

class _CreatePINState extends State<CreatePIN> {
  String _input = "", uid = '';
  String _pass = "";
  // ignore: unused_field
  String _passConfirm = "";
  bool _isConfirm = false;

  void addString(String index) {
    setState(() {
      if (_input.length < 4) _input += index.toString();
      if (_input.length == 4 && _pass == "") {
        _pass = _input;
        _input = "";
        _isConfirm = true;
      }
      if (_input.length == 4 && _pass != "") {
        _passConfirm = _input;
      }
      if (_passConfirm == _pass && _pass.length == 4) {
        CheckPin();
      } else if (_passConfirm.length == 4) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const OnBoard()));
      }
    });
  }

  void removeString() {
    setState(() {
      if (_input.length > 0) _input = _input.substring(0, _input.length - 1);
    });
  }

  void loadID() {
    if (uid == '')
      setState(() {
        print("Set IDDD");
        uid = FirebaseAuth.instance.currentUser!.uid;
      });
  }

  // ignore: non_constant_identifier_names
  void CheckPin() {
    if (uid != '') {
      FirebaseFirestore.instance.collection('users').doc(uid).update(
        {'pin': Crypt.sha256(_pass, rounds: 10000, salt: 'viiducc').hash},
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  void prevToCreate() {
    setState(() {
      _input = "";
      _pass = "";
      _passConfirm = "";
      _isConfirm = false;
    });
  }

  @override
  void initState() {
    loadID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          !_isConfirm ? "Create a PIN" : "Confirm PIN",
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
          Text(
            !_isConfirm
                ? 'Enhance the security of your account by creating \na PIN code'
                : "Repeat a PIN code to continue",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Color(0xFF485068)),
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
                      color: i < _input.length
                          ? Color(0xFF75BF72)
                          : Color(0xFF9EA5B1),
                    ),
                  ),
                )
            ],
          ),
          NumKeyBoard(pressAddString: addString, removeString: removeString)
        ],
      ),
    );
  }
}
