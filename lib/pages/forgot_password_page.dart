import 'package:dragondeutsch/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController=TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),);
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            content: Text('Password reset link sent! Check your email'),
        );
      });
    }on FirebaseAuthException catch(e){
      print(e);

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restart Password')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40,),
            Image.asset('assets/images/logo.png',height: 150,),
            const SizedBox(height: 40,),
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 25.0),
              child: Text('Enter your email and we will sending you a password reset link', style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 10,),
            MyTextField(hintText: 'Email', obscureText: false,controller: emailController),
            MaterialButton(onPressed: (){
             passwordReset();
            },color: const Color.fromARGB(255, 178, 43, 34),child: Text('Reset Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),)
          ],
        ),),
    );
  }
}