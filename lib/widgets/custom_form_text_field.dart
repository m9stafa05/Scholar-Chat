import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.onChange,
    this.isPassword = false,
  });
  final String labelText;
  final String hintText;
  Function(String)? onChange;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 400,
        child: TextFormField(
          obscureText: isPassword == true ? true : false,
          validator: (data) {
            if (data!.isEmpty) {
              return 'This field is required';
            } else {
              return null;
            }
          },
          onChanged: onChange,
          style: TextStyle(
            color: const Color(0xFFFFFFFF),
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color(0xFF949494),
              fontSize: 10,
            ),
            labelText: labelText,
            labelStyle: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontSize: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
