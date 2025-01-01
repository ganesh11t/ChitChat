import 'package:chitchat/screens/splash_screen.dart';
import 'package:flutter/material.dart';
// import 'screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//global object for accessing device screen size
late Size mq;

void main() {
  _initiateFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChitChat',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),

        backgroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 51, 0, 255),
        // Theme.of(context).primaryColor,
      )
          // primarySwatch: Colors.red,
          // primaryColor: Colors.deepPurple,
          ),
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // useMaterial3: true,

      home: const SplashScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

_initiateFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
