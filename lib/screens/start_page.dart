import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        nextScreen:AfterSplash() ,
        splash: Center(
          child: Lottie.asset('assets/dk_2.json',width: 800,height: 800),
        ),
        animationDuration: Duration(seconds: 2),
        curve: Curves.bounceIn,
        
      ),
    );
  }
}



class AfterSplash extends StatelessWidget {
  const AfterSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children:[
          Image.asset('assets/ent.png'),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/onboard');
              }, 
              child: Text(
                "Lets go",style: TextStyle(fontSize: 20,color: Colors.black),
                ),)),
          ])
      ),
    );
  }
}