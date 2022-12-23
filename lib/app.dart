import 'package:flutter/material.dart';

import 'config/themes.dart';
import 'ui/screens/splashscreen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clerkship Logbook',
      theme: ThemeData(
        primarySwatch: Themes.primaryMaterialColor,
        scaffoldBackgroundColor: Themes.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
