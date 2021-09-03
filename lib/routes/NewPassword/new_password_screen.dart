import 'package:flutter/material.dart';
import 'package:wallet_app/routes/CheckYourEmail/check_email_screen.dart';
import 'package:wallet_app/routes/Widgets/password_field_widget.dart';
import 'package:wallet_app/routes/Widgets/primary_button_widget.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffedf1f9),
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF0D1F3C),
        ),
        title: const Text(
          "Create New Password",
          style: TextStyle(
              fontSize: 26,
              color: Color(0xFF0D1F3C),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffedf1f9),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Your new password must be different from a \npreviously used password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 110,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    PasswordFieldWidget(
                        label: 'New password', controller: passwordController),
                    PasswordFieldWidget(
                        label: 'Repeat password',
                        controller: repeatPasswordController),
                    const SizedBox(height: 50),
                    PrimaryButton(
                        textButton: 'Reset Password',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CheckEmail()));
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
