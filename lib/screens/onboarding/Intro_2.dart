import 'package:flutter/material.dart';

class Intro2 extends StatelessWidget {
  const Intro2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/notii.png'),
              const Text("Receive real-time notifications, making the request acceptance faster. 🔔",
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
              textAlign:  TextAlign.center,
              ),
          ],
        ),
        ),
    );
  }
}