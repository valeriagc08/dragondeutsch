import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

 MyTextField({super.key, this.controller, required this.hintText, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: hintText,
                  //Border 
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                  //Border for inputData
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50))
                  ),
                  ),
    );
  }
}