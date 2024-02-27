import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user= FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          Stack(
            children:[ 
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(400, 90)),
                  color: Color.fromARGB(255, 157, 43, 35),)
                ),
              Column(
                children: [
                  const SizedBox(height: 90,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text('My Profile ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.white))],),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.supervised_user_circle, size: 70, color: Colors.white,),
                        Text(user.email!,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white))],),
                  ),
                ],
              ),
          ]),
          const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text('My account ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black))],),
          ),
          const SizedBox(height: 30,),
          MaterialButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            },
            color: const Color.fromARGB(255, 183, 50, 41),
            child: Text('Sign out'),
          )
        ],
      )),
    );
  }
}