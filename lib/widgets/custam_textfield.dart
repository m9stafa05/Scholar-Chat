import 'package:flutter/material.dart';

class CustamTextField extends StatelessWidget {
  const CustamTextField({
    super.key,
    required this.labelText,
    required this.hintText,
  });
  final String labelText;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 400,
        child: TextField(
          style: TextStyle(
            color: const Color(0xFFFFFFFF),
            fontSize: 20,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color.fromARGB(
                255,
                148,
                148,
                148,
              ),
              fontSize: 10,
            ),
            labelText: labelText,
            labelStyle: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontSize: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
