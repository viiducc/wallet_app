import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_app/routes/OnBoard/OnBoardWiget/onboard_widget.dart';
import 'package:wallet_app/routes/Welcome/welcome_screen.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  // Set Visibility for Skip Text
  bool skip = true;

  //Change Button last page
  String textButton = 'Next Step';
  Color textColor = Color(0xFF347AF0);
  Color backgroundButton = Colors.white;

  int currentPage = 0;
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: const [
                OnBoardWidget('Step1', 'Welcome to\n Whollet',
                    'Manage all your crypto assets! It’s simple\n and easy! '),
                OnBoardWidget('Step2', 'Nice and Tidy Crypto Portfolio!',
                    'Keep BTC, ETH, XRP, and many other\n ERC-20 based tokens.'),
                OnBoardWidget('Step3', 'Receive and Send Money to Friends!',
                    'Send crypto to your friends with a personal\n message attached. '),
                OnBoardWidget('Step4', ' Your Safety is Our\n Top Priority',
                    'Our top-notch security features will keep \nyou completely safe.'),
              ],
              onPageChanged: (value) => {setCurrentPage(value)},
            ),
            Visibility(
              visible: skip,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _pageController.animateToPage(3,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeInOut);
                          // _pageController
                        });
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                            color: Color(0xFF347AF0),
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.height) / 2 - 80,
              left: (MediaQuery.of(context).size.width) / 2 - 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) => getIndicator(index)),
              ),
            ),
            Positioned(
              bottom: 60,
              left: (MediaQuery.of(context).size.width - 200) / 2,
              child: OutlinedButton(
                onPressed: () {
                  currentPage == 3
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Welcome()))
                      : _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: backgroundButton,
                  fixedSize: const Size(200, 46),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23)),
                  side: const BorderSide(
                    color: Color(0xFF347AF0),
                  ),
                ),
                child: Text(
                  textButton,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer getIndicator(int pageNo) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: 10,
      width: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: (currentPage == pageNo)
              ? const Color(0xFF347AF0)
              : const Color(0xFFEDF1F9)),
    );
  }

  setCurrentPage(int value) {
    currentPage = value;
    // setState(() {});
    setState(() {
      if (currentPage == 3) {
        skip = false;
        textButton = "Let's Get Started";
        textColor = Colors.white;
        backgroundButton = Color(0xFF347AF0);
      } else {
        skip = true;
        textButton = "Next Step";
        textColor = Color(0xFF347AF0);
        backgroundButton = Colors.white;
      }
    });
  }
}
