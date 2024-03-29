import 'package:dragondeutsch/pages/my_log_page.dart';
import 'package:dragondeutsch/pages/register_page.dart';
import 'package:flutter/material.dart';
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially, show the login page
  bool showLoginPage=true;
  void toggleScreens(){
    setState(() {
      showLoginPage= !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return MyLogPage(showRegisterPage:  toggleScreens);
    }else{
      return RegisterPage(showLoginPage: toggleScreens,);
    }
  }
}