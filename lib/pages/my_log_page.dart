import 'package:dragondeutsch/components/my_bottom.dart';
import 'package:dragondeutsch/components/text_field.dart';
import 'package:dragondeutsch/pages/forgot_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLogPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const MyLogPage({super.key, required this.showRegisterPage});

  @override
  State<MyLogPage> createState() => _MyLogPageState();
}

class _MyLogPageState extends State<MyLogPage> {
  //text editing Controllers
  final passwordController= TextEditingController();
  final emailController= TextEditingController();

  //sign use in method
  Future signUserIn()async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim(),
      );
  }
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Center(
          child: 
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Logo DragonDeutsch
                Image.asset('assets/images/logo.png',height: 180,),
                const SizedBox(height: 10,),
            
                //Email Text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('Input Your Email: ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))],),
                ),
                const SizedBox(height: 8,),
            
                //Email TextField
                MyTextField(controller: emailController,hintText: 'Email', obscureText: false),
                
            
                //Password Text
                const SizedBox(height: 8,),
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('Input Your Password: ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))],),
                ),
                const SizedBox(height: 8,),
            
                //Password TextField
                MyTextField(controller: passwordController,hintText: 'Password', obscureText: true),
                const SizedBox(height: 10,),

                //Forgot Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context){
                                  return ForgotPassword();
                            }));
                          },
                          child: Text(
                            'Forgot Password? ', 
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold ),
                            ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 10,),
                //SignedBottom
                MyBottom(onTap: signUserIn, title: 'Sign In'),
                const SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Doesn\'t have an acount? ', 
                        style: TextStyle(
                          color: Colors.grey, ),
                        ),
                      GestureDetector(
                        onTap:widget.showRegisterPage,
                        child: const Text(
                          'Register', 
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.red, 
                            fontWeight: FontWeight.bold),
                          ),
                        ),
                  ],
                ),
              )
              ],
            ),
          ),
          
        ),
      ),
    );
  }
}