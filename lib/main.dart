import 'package:flutter/material.dart';
import 'package:permitease/auth_pages/auth_page.dart';
import 'package:permitease/auth_pages/login.dart';
import 'package:permitease/auth_pages/signup.dart';
import 'package:permitease/screens/onboarding.dart';
import 'package:permitease/screens/start_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/auth':(context)=>const Auth(),
        '/onboard':(context)=>const Onboarding(),
        '/login':(context)=>const Login(),
        '/create':(context)=>const Signup()
      },
      home: Start(),
    );
  }
}

