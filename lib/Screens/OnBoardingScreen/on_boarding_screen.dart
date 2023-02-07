import 'package:flutter/material.dart';
import 'package:introduction_slider/introduction_slider.dart';
import 'package:take_home/Screens/Home/home.dart';

import '../login_screen/login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionSlider(
      items: const [
        IntroductionSliderItem(
          logo: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Image(image: AssetImage('assets/images/onb1.png')),
          ),
          title: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("Welcome To Take Home",
              textAlign: TextAlign.center,
              style: TextStyle(
              color: Colors.black,
              fontSize: 20,
                  fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800
            ),),
          ),
          subtitle: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis imperdiet massa tincidunt nunc pulvinar sapien et ligula. Donec pretium vulputate sapien nec sagittis. Ut eu sem integer vitae justo eget magna.",  style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat'
            ), textAlign: TextAlign.center,),
          ),
          backgroundColor: Colors.white
        ),
        IntroductionSliderItem(
          logo: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Image(image: AssetImage('assets/images/onb2.png')),
          ),
          title: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("Manage your tasks",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Montserrat'
              ),),
          ),
          subtitle: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis imperdiet massa tincidunt nunc pulvinar sapien et ligula. Donec pretium vulputate sapien nec sagittis. Ut eu sem integer vitae justo eget magna.",  style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat'
            ), textAlign: TextAlign.center,),
          ),
          backgroundColor: Colors.white
        ),
        IntroductionSliderItem(
          logo: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Image(image: AssetImage('assets/images/onb3.png')),
          ),
          title: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("Get Started!!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Montserrat'
              ),),
          ),
          subtitle: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis imperdiet massa tincidunt nunc pulvinar sapien et ligula. Donec pretium vulputate sapien nec sagittis. Ut eu sem integer vitae justo eget magna.",  style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat'
            ), textAlign: TextAlign.center,),
          ),
         backgroundColor: Colors.white),
      ],

      done: const Done(
        child: Icon(Icons.done, color: Colors.purple,),
        home: LoginScreen(),
      ),
      next: const Next(child: Icon(Icons.arrow_forward, color: Colors.purple,)),
      back: const Back(child: Icon(Icons.arrow_back, color: Colors.purple,)),
      dotIndicator: const DotIndicator(selectedColor: Colors.purple,),
    );
  }
}