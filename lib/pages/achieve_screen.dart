import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AchieveScreen extends StatefulWidget {
  const AchieveScreen({super.key});

  @override
  State<AchieveScreen> createState() => _AchieveScreenState();
}

class _AchieveScreenState extends State<AchieveScreen> {
  final user= FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100,),
          Image.asset('assets/images/logo.png'),
          Center(child: Icon(Icons.warning, size: 100,color: Colors.orange,)),
          Text('Ups! this page is not available', style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}