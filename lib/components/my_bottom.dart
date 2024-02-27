import 'package:flutter/material.dart';

class MyBottom extends StatelessWidget {
  final Function()? onTap;
  String title;
  MyBottom({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromARGB(255, 159, 47, 39)
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center, 
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold, 
                fontSize: 16),
                ),
              ),
            ),
    );
  }
}