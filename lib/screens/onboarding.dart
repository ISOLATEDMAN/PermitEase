import 'package:flutter/material.dart';
import 'package:permitease/screens/onboarding/Intro_1.dart';
import 'package:permitease/screens/onboarding/Intro_2.dart';
import 'package:permitease/screens/onboarding/Intro_3.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
          PageView(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            children: const [
              Intro1(),
              Intro2(),
              Intro3(),
            ],
          )
        
    );
  }
}