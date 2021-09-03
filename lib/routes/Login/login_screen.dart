import 'package:flutter/material.dart';
import 'package:wallet_app/routes/EnterPIN/enter_pin_screen.dart';
import 'package:wallet_app/routes/ForgotPassword/forgot_password_screen.dart';
import 'package:wallet_app/routes/SignUp/sign_up_screen.dart';
import 'package:wallet_app/routes/Widgets/password_field_widget.dart';
import 'package:wallet_app/routes/Widgets/primary_button_widget.dart';
import 'package:wallet_app/routes/Widgets/text_field_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    bool isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffedf1f9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "Welcome Back!",
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
          children: [
            const SizedBox(
              height: 40,
            ),
            !isKeyBoard
                ? Image.asset('assets/images/login/login.png')
                : Container(),
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
                    TextFieldWidget(
                        label: 'Email address', controller: emailController),
                    const SizedBox(height: 25),
                    PasswordFieldWidget(
                        label: 'Password', controller: passwordController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassword()));
                          },
                          child: const Text(
                            'Forgot your password?',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff347AF0)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 110),
                    PrimaryButton(
                        textButton: 'Login',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EnterPIN()));
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Dont't have an account?",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF485068))),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff347AF0)),
                          ),
                        ),
                      ],
                    ),
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
