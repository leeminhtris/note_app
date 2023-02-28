import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:note/src/page/app.dart';

void main() async {
  //This is the glue that binds the framework to the Flutter engine.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ghi chú",
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,  //độ tương thích màn hình
      ),
      home: AnimatedSplashScreen(
          splash: const Text("Design by Tri Le Minh"),
          splashTransition: SplashTransition.slideTransition,
          nextScreen: const MyHomePage(),
      )
    );
  }
}


