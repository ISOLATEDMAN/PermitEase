import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding:EdgeInsets.all(30) ,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Lottie.asset('assets/log.json',width: 300,height: 300),
              SizedBox(height: 30,),
              Text("HEY...",style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),
              Text("Get Instant Permission approvalss..😎😎",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
              SizedBox(height: 30,),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/login');
                  }, child: Text("LOGIN",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Color.fromARGB(255, 255, 255, 255)),),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<BeveledRectangleBorder>(BeveledRectangleBorder(),),
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 42, 158))
                  ),
              ),),
            SizedBox(height: 20,),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/create');
                  }, child: Text("SIGN UP",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Color.fromARGB(255, 255, 255, 255)),),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<BeveledRectangleBorder>(BeveledRectangleBorder(),),
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 42, 158)),
                  ),
              ),),

            ],
          ),
        ),
        ),
    );
  }
}