import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dragondeutsch/components/my_bottom.dart';
import 'package:dragondeutsch/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage ({super.key, required this.showLoginPage});

  @override
  State<RegisterPage > createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing Controllers
  final _passwordController= TextEditingController();
  final _emailController= TextEditingController();
  final _confirmPasswordController= TextEditingController();
  final _firstNameController= TextEditingController();
  final _ageController= TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
   _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _ageController.dispose();
    
    super.dispose();
  }


  //athentic the user
  Future signUp()async{
    if(passwordConfirm()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(), 
        password: _passwordController.text.trim()
      );
      //add user details
      addUserDetails(
        _emailController.text.trim(), 
        _firstNameController.text.trim(), 
        int.parse(_ageController.text.trim())
      );
    }
  }

  Future addUserDetails(String email, String firstName, int age)async{
    await FirebaseFirestore.instance.collection('users').add({
      'email': email,
      'first name': firstName,
      'age': age,
      
    });
  }
  bool passwordConfirm(){
    if(
      _confirmPasswordController.text.trim()==
      _passwordController.text.trim()){
     return true;
    }else{
     return false;
    }
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
                Image.asset('assets/images/logo.png',height: 100,),
                const SizedBox(height: 10,),
                //Text for Register
                Text('Register below with your details!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                MyTextField(controller: _emailController,hintText: 'Email', obscureText: false),
                
            
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
                MyTextField(controller: _passwordController,hintText: 'Password', obscureText: true),
                const SizedBox(height: 8,),
                MyTextField(controller: _confirmPasswordController,hintText: 'Confirm Password', obscureText: true),
                const SizedBox(height: 15,),
                
                //FirstName
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('Input Your First Name: ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))],),
                ),
                const SizedBox(height: 8,),
                MyTextField(controller: _firstNameController,hintText: 'First Name', obscureText: false),
                const SizedBox(height: 8,),

                //Age
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('Input Your Age: ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))],),
                ),
                const SizedBox(height: 8,),
                MyTextField(controller: _ageController,hintText: 'Age', obscureText: false),
                const SizedBox(height: 14,),


                MyBottom(onTap: signUp,title: 'SignUp',),
                const SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have an acount? ', 
                        style: TextStyle(
                          color: Colors.grey, ),
                        ),
                      GestureDetector(
                        onTap:widget.showLoginPage,
                        child: const Text(
                          'LogIn', 
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