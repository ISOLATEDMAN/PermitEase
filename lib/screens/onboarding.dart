import 'package:flutter/material.dart';
import 'package:permitease/screens/onboarding/Intro_1.dart';
import 'package:permitease/screens/onboarding/Intro_2.dart';
import 'package:permitease/screens/onboarding/Intro_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
      Stack(
        children: [
      PageView(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            children: const [
              Intro1(),
              Intro2(),
              Intro3(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child:Padding(
            padding: EdgeInsets.all(12),
             child:SmoothPageIndicator(
              controller: _controller,
               count: 3,
               effect: SwapEffect(activeDotColor: Color.fromARGB(255, 98, 0, 255)),),
            ),),
        ])
    );
  }
}


// ElevatedButton(
//   onPressed: () {
//     if (_pageController.page == 2) {
//       // Navigate to home screen
//     } else {
//       _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
//     }
//   },
//   child: Text(_pageController.page == 2 ? "Get Started" : "Next"),
// )