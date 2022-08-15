import 'package:flutter/material.dart';
import 'package:tic_tac_toe1/game_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Morpion',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(),
          Image.asset(
            "assets/splash1.png",
            width: 125.0,
            height: 125.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            "MORPION",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,),
          ),
          const Spacer(
            flex: 2,
          ),
          const Text("Design by Bibou"),
          // Spacer(),
        ],
      ),
      backgroundColor: Colors.white,
      nextScreen: const GamePage(),
      splashIconSize: 550,
      splashTransition: SplashTransition.fadeTransition,
      duration: 4000,
      pageTransitionType: PageTransitionType.leftToRight,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
