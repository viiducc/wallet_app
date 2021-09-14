import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/routes/Login/login_screen.dart';
import 'package:wallet_app/routes/Widgets/primary_button_widget.dart';
import 'package:wallet_app/routes/Widgets/text_field_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = '';
  double _balance = 0;
  String firstName = '', lastName = '', primaryKey = '', address = '';
  bool isBalance = false;

  TextEditingController icxSendController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool _isObscure = true;
  String status = "Transfer";

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    icxSendController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void loadID() {
    if (uid == '')
      setState(() {
        uid = FirebaseAuth.instance.currentUser!.uid;
      });
  }

  void loadData() {
    if (uid != '') {
      FirebaseFirestore.instance.collection('users').doc(uid).get().then(
        (DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists && primaryKey == '') {
            setState(() {
              //print(documentSnapshot.data());
              primaryKey = documentSnapshot.get('primary_key');
              address = documentSnapshot.get('address');
              firstName = documentSnapshot.get('first_name');
              lastName = documentSnapshot.get('last_name');
            });
          }
        },
      );
    }
  }

  Future<void> transferICX() async {
    // if (_formKey.currentState!.validate()) {
    // print("ICX ${_ICXController.text}");
    // print("Address ${_addressController.text}");
    setState(() {
      status = "Loading";
    });
    final tHash = await FlutterIconNetwork.instance!.sendIcx(
        yourPrivateKey: primaryKey,
        destinationAddress: addressController.text,
        value: icxSendController.text);
    _showTransferDialog(
      idTransaction: tHash.txHash.toString(),
      from: address,
      to: addressController.text,
      values: icxSendController.text,
      context: context,
    );
    setState(() {
      status = "Transfer";
      icxSendController.clear();
      addressController.clear();
    });
    // }
  }

  void loadBalance() async {
    if (primaryKey != '') {
      final balance = await FlutterIconNetwork.instance!
          .getIcxBalance(privateKey: primaryKey);
      if (_balance != balance.icxBalance) {
        setState(() {
          _balance = balance.icxBalance;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    loadID();
    loadData();
    loadBalance();
    // print(_address);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF99B9EE),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            "Wallet ICX",
            style: TextStyle(
                fontSize: 26,
                color: Color(0xFF0D1F3C),
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFEDF1F9),
          actions: [
            const CircleAvatar(
              child: Icon(
                Icons.account_circle_outlined,
                size: 30,
              ),
              radius: 15,
              backgroundColor: Color(0xFFEDF1F9),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                logOut();
              },
              icon: Icon(Icons.logout, color: Color(0xFF0D1F3C)),
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
                      Text(
                        'Hi, ${firstName + lastName}',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w300),
                      ),
                      IconButton(
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                            // print(_isObscure);
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
                            _isObscure
                                ? '*******'
                                : _balance.toStringAsFixed(4),
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
                            _isObscure
                                ? '*******'
                                : (_balance * 1.751423).toStringAsFixed(4),
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
                    TextFieldWidget(
                        label: 'Enter ICX', controller: icxSendController),
                    TextFieldWidget(
                        label: 'Enter destination address',
                        controller: addressController),
                    !isKeyBoard
                        ? SizedBox(
                            height: 80,
                          )
                        : SizedBox(
                            height: 16,
                          ),
                    OutlinedButton(
                      onPressed: () {
                        transferICX();
                      },
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
                      child: Text(
                        address,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.red,
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: address));
                      },
                      child: Row(
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> logOut() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you sure?',
            style: TextStyle(
                height: 2,
                color: Color(0xFF313131),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          content: const Text(
            'You will be redirected to login ',
            style: TextStyle(height: 2, color: Color(0xFF313131), fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF96060))),
              // color: Color(0xFFF96060))),
              onPressed: () async {
                //Log out user Firebase
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
            ),
            TextButton(
              child: const Text('No',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                Navigator.of(context).pop(); //Dismiss the Dialog
              },
            ),
          ],
        );
      },
    );
  }
}

Future<void> _showTransferDialog(
    {required String idTransaction,
    required String from,
    required String to,
    required String values,
    required BuildContext context}) async {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm:ss').format(now);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Transaction Details',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold
              // decoration: TextDecoration.underline,
              ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              DoubleText(title: 'Time', content: formattedDate),
              DoubleText(title: 'Total amount', content: values),
              DoubleText(title: 'Transaction ID', content: idTransaction),
              DoubleText(title: 'From', content: from),
              DoubleText(title: 'To', content: to),
              SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: PrimaryButton(
                      textButton: 'Back to my Wallet',
                      onPressed: () {
                        Navigator.pop(context);
                      })),
            ],
          ),
        ),
      );
    },
  );
}

class DoubleText extends StatelessWidget {
  const DoubleText({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title, content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                // color: AppColors.kTextLightColor,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: content));
              },
              icon: Icon(
                Icons.copy,
                size: 20,
              ),
            ),
          ],
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
