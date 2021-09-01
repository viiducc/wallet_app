import 'package:flutter/material.dart';

class OnBoardWidget extends StatefulWidget {
  final String image;
  final String title;
  final String detail;
  const OnBoardWidget(this.image, this.title, this.detail);

  @override
  State<OnBoardWidget> createState() => _OnBoardWidgetState();
}

class _OnBoardWidgetState extends State<OnBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        children: [
          Container(
              height: 214,
              width: 318,
              margin: const EdgeInsets.fromLTRB(24, 106, 24, 24),
              child: Image.asset('assets/images/onboard/${widget.image}.png')),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(24, 70, 24, 11),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xFF0D1F3C),
                          fontSize: 36,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    widget.detail,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF485068),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
