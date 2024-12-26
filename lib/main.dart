import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
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
        // Theme.of(context).primaryColor,
      )
          // primarySwatch: Colors.red,
          // primaryColor: Colors.deepPurple,
          ),
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // useMaterial3: true,

      home: const HomeScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
