import 'package:flutter/material.dart';
import 'package:wallet_app/routes/Login/login_screen.dart';
import 'package:wallet_app/routes/SignUp/sign_up_screen.dart';
import 'package:wallet_app/routes/Widgets/primary_button_widget.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF1F9),
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF0D1F3C),
        ),
        title: const Text(
          "Check Your Email",
          style: TextStyle(
              fontSize: 26,
              color: Color(0xFF0D1F3C),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFEDF1F9),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Follow a password recovery instructions we have\n just sent to your email address ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            Image.asset('assets/images/checkemail/email.png'),
            Column(
              children: [
                PrimaryButton(
                    textButton: 'Back to Login',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    }),
                const SizedBox(
                  height: 70,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
