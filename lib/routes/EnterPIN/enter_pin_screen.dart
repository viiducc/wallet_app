import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_app/routes/Widgets/num_keyboard_widget.dart';

class EnterPIN extends StatefulWidget {
  const EnterPIN({Key? key}) : super(key: key);

  @override
  _EnterPINState createState() => _EnterPINState();
}

class _EnterPINState extends State<EnterPIN> {
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
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: i < _password.length
                        //     ? Color(0xFF75BF72)
                        //     : Color(0xFF9EA5B1),
                        color: Color(0xFF75BF72)),
                  ),
                )
            ],
          ),
          NumKeyBoard()
        ],
      ),
    );
  }
}