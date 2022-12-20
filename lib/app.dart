import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/screens/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clerkship Logbook',
      theme: ThemeData(
        primarySwatch: Themes.primaryMaterialColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
