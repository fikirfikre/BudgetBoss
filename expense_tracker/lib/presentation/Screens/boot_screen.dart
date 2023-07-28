import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:budget_boss/presentation/Screens/onbording_screen.dart';
import 'package:budget_boss/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class BootScreen extends StatefulWidget {
  const BootScreen({super.key});

  @override
  State<BootScreen> createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen> {
  @override
  Widget build(BuildContext context) {
    TextStyle txtstyle = const TextStyle(
        fontSize: 80, color: Colors.white, fontWeight: FontWeight.bold);
    var animatedTextKit = AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText('Budget',
            textStyle: txtstyle,
            speed: const Duration(milliseconds: 500),
            curve: Curves.linear),
      ],
      //  displayFullTextOnTap: true,
      totalRepeatCount: 1,
      repeatForever: true,
      onTap: () {
       Navigator.pushNamed(context, RouteGenerator.onboardScreen);
      },
    );
    var animatedTextKit2 = AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText('Boss',
            textStyle: txtstyle,
            speed: const Duration(milliseconds: 500),
            curve: Curves.linear)
      ],
      //  displayFullTextOnTap: true,
      totalRepeatCount: 1,
    );
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [animatedTextKit, animatedTextKit2],
          ),
        ),
      ),
    );
  }
}
