import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class Intro1 extends StatefulWidget {
  const Intro1({super.key});

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Lottie.asset('assets/plzz.json',width: 500,height: 500),
              const Text("Submit, track, and manage requests effortlessly.Say goodbye to paperwork and manual processing👋",
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
              textAlign:  TextAlign.center,
              ),
              
              
          ],),
      ),
    );
  }
}