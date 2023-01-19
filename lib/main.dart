import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_it/get_it.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'config/environment.dart';
import 'injection.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
    debug:
        true, // optional: set to false to disable printing logs to console (default: true)
    ignoreSsl:
        true, // option: set to false to disable working with http links (default: false)
  );

  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.dev,
  );

  Environment().initConfig(environment);
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  runApp(provideInjection());
}
