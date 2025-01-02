import 'package:chitchat/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'home_screen.dart';

//Splash screen for the app
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      // app bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome to ChitChat'),
      ),

      // body
      body: Stack(
        children: [
          // app logo
          Positioned(
              top: mq.height * .15,
              right: mq.width * .25,
              width: mq.width * .5,
              child: Image.asset('images/icon.png')),

          // login with google button
          Positioned(
              bottom: mq.height * .15,
              width: mq.width,
              child: const Text(
                'Made in Nepal with ❤️',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Colors.black, letterSpacing: .5),
              )),
        ],
      ),
    );
  }
}
