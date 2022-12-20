import 'package:clerkship/injection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'config/environment.dart';

final getIt = GetIt.instance;

void main() {
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.dev,
  );

  Environment().initConfig(environment);
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  runApp(provideInjection());
}
