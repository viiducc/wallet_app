import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const TextFieldWidget(
      {Key? key, required this.label, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 19, color: Color(0xFF0D1F3C)),
      decoration: InputDecoration(
        //border: UnderlineInputBorder(),
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w400,
          color: Color(0xFFB5BBC9),
        ),
      ),
    );
  }
}
