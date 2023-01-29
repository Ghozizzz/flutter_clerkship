import 'package:clerkship/ui/screens/standard_competency_lecture/provider/standart_competency_lecture_provider.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'data/shared_providers/auth_provider.dart';
import 'ui/screens/standard_competency/provider/standart_competency_provider.dart';

MultiProvider provideInjection() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => StandartCompetencyProvider()),
      ChangeNotifierProvider(
          create: (_) => StandartCompetencyLectureProvider()),
    ],
    child: const MyApp(),
  );
}
