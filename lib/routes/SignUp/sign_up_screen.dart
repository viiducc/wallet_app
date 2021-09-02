import 'package:flutter/material.dart';
import 'package:wallet_app/routes/Login/login_screen.dart';
import 'package:wallet_app/routes/Widgets/password_field_widget.dart';
import 'package:wallet_app/routes/Widgets/primary_button_widget.dart';
import 'package:wallet_app/routes/Widgets/text_field_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final bool _isObscure = true;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    bool isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEDF1F9),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Create Account!",
          style: TextStyle(
              fontSize: 26,
              color: Color(0xFF0D1F3C),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFEDF1F9),
      ),
      body: isloading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: const CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  !isKeyBoard
                      ? Image.asset('assets/images/signup/office.png')
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
                              label: 'First Name',
                              controller: firstNameController),
                          TextFieldWidget(
                              label: 'Last Name',
                              controller: lastNameController),
                          TextFieldWidget(
                              label: 'Email', controller: emailController),
                          PasswordFieldWidget(
                              label: 'Password',
                              controller: passwordController),
                          !isKeyBoard
                              ? const SizedBox(
                                  height: 19,
                                )
                              : Container(),
                          const SizedBox(
                            height: 13,
                          ),
                          // OutlinedButton(
                          //   onPressed: () {
                          //     // Navigator.push(
                          //     //         context,
                          //     //         MaterialPageRoute(
                          //     //             builder: (context) => const Welcome()))
                          //   },
                          //   style: OutlinedButton.styleFrom(
                          //     backgroundColor: Color(0xFF347AF0),
                          //     fixedSize: const Size(200, 46),
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(23)),
                          //     side: const BorderSide(
                          //       color: Color(0xFF347AF0),
                          //     ),
                          //   ),
                          //   child: const Text(
                          //     'Let’s Get Started',
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 19,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                          PrimaryButton(
                              textButton: 'Let’s Get Started',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF485068))),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF347AF0)),
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
