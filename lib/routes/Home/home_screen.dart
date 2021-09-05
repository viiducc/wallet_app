import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet_app/routes/Widgets/primary_button_widget.dart';
import 'package:wallet_app/routes/Widgets/text_field_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController icxSend = TextEditingController();
  TextEditingController address = TextEditingController();
  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    bool isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF99B9EE),
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Wallet ICX",
            style: TextStyle(
                fontSize: 26,
                color: Color(0xFF0D1F3C),
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFEDF1F9),
          actions: const [
            CircleAvatar(
              child: Icon(
                Icons.account_circle_outlined,
                size: 30,
              ),
              radius: 15,
              backgroundColor: Color(0xFFEDF1F9),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.logout,
              color: Color(0xFF0D1F3C),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 400),
          backgroundColor: Colors.white,
          color: Color(0xFF99B9EE),
          height: 50,
          items: [
            SvgPicture.asset(
              'assets/icons/home/send.svg',
              color: Colors.black,
              height: 60,
              width: 60,
            ),
            SvgPicture.asset(
              'assets/icons/home/request.svg',
              color: Colors.black,
              height: 60,
              width: 60,
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              height: 120,
              color: Color(0xFF99B9EE).withOpacity(0.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hi, Vi Đức!',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w300),
                      ),
                      IconButton(
                        icon: Icon(
                          _isObscure == false
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                            print(_isObscure);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            _isObscure ? '*******' : '123456',
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'ICX',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _isObscure ? '*******' : '123456',
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '\$',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  // borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: [
                    TextFieldWidget(label: 'Enter ICX', controller: icxSend),
                    TextFieldWidget(
                        label: 'Enter destination address',
                        controller: address),
                    !isKeyBoard
                        ? SizedBox(
                            height: 80,
                          )
                        : SizedBox(
                            height: 16,
                          ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: const Size(200, 46),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23)),
                        side: const BorderSide(
                          width: 3,
                          color: Color(0xFF347AF0),
                        ),
                      ),
                      child: const Text(
                        'Transfer',
                        style: TextStyle(
                            color: Color(0xFF347AF0),
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    !isKeyBoard
                        ? SizedBox(
                            height: 80,
                          )
                        : SizedBox(
                            height: 16,
                          ),
                    Container(
                      padding: EdgeInsets.all(5),
                      // height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: const Color(0xFF99B9EE).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        'asd45asd1as1da1s4d85a6sawad...',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Copy my address',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(Icons.content_copy),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
