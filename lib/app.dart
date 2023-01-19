import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

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

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }
}
