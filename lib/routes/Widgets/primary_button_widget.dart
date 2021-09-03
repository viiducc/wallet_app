import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String textButton;
  final GestureTapCallback onPressed;

  const PrimaryButton(
      {Key? key, required this.textButton, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          fixedSize: const Size(200, 46),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xFF347AF0)),
      onPressed: onPressed,
      child: Text(
        textButton,
        style: const TextStyle(
            color: Colors.white, fontSize: 19, fontWeight: FontWeight.w600),
      ),
    );
  }
}
