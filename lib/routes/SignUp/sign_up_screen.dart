import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:wallet_app/routes/CreatePIN/create_pin_screen.dart';
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

  bool _isObscure = true;
  bool isloading = false;
  String _status = '';
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _checkSignUp() async {
    setState(() {
      _status = '';
    });
    // if (_formKey.currentState!.validate()) {
    // print("Email ${_emailController.text}");
    // print("Email ${_passwordController.text}");
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (userCredential.user != null) {
        final wallet = await FlutterIconNetwork.instance!.createWallet;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid.toString())
            .set({
              'first_name': firstNameController.text,
              'last_name': lastNameController.text,
              'uid': userCredential.user!.uid.toString(),
              'email': emailController.text,
              'address': wallet.address,
              'primary_key': wallet.privateKey,
              'pin': {'pin': '1234'},
            })
            .then((value) => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreatePIN()))
                })
            .catchError((error) =>
                // ignore: invalid_return_type_for_catch_error
                print("Failed to add user: $error"));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          _status = 'The password provided is too weak.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          _status = 'The account already exists for that email.';
        });
      }
    } catch (e) {
      print(e);
    }
    // }
  }

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
                          PrimaryButton(
                              textButton: 'Let’s Get Started',
                              onPressed: () {
                                _checkSignUp();
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
