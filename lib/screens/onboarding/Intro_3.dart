import 'package:flutter/material.dart';

class Intro3 extends StatelessWidget {
  const Intro3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:const  EdgeInsets.all(12),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/sec.png'),
              const Text("Safely Secure all the permissions and manage all the documents🔔",
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
              textAlign:  TextAlign.center,
              ),
              SizedBox(height: 50,),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(onPressed: (){
                  
                  Navigator.pushNamed(context, '/auth');
                }, child: Text("Next..",style: TextStyle(fontSize: 35,color:Color.fromARGB(255, 0, 0, 0)),),
                style: ButtonStyle(backgroundColor:WidgetStateColor.transparent),
                )),
          ],
        ) ,),
    );
  }
}