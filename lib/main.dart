import 'package:clerkship/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_it/get_it.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'config/environment.dart';
import 'injection.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );

  FlutterDownloader.registerCallback(MyApp.downloadCallback);

  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.dev,
  );

  Environment().initConfig(environment);
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  runApp(provideInjection());
}
