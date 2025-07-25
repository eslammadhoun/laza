import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormField extends StatelessWidget {
  CustomFormField({
    super.key,
    required this.labelText,
    required this.suffixWidget,
    required this.validator,
    required this.controller,
    required this.obscureText,
  });

  String labelText;
  Widget suffixWidget;
  String? Function(String?)? validator;
  TextEditingController controller;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE7E8EA)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 118, 118, 118)),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Color(0xff8F959E),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
        suffix: suffixWidget,
      ),
      validator: validator,
      obscureText: obscureText,
    );
  }
}
