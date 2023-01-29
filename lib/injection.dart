import 'package:provider/provider.dart';

import 'app.dart';
import 'data/shared_providers/auth_provider.dart';
import 'ui/screens/standard_competency/provider/standart_competency_provider.dart';

MultiProvider provideInjection() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => StandartCompetencyProvider()),
    ],
    child: const MyApp(),
  );
}
