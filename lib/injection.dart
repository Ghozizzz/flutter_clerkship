import 'package:clerkship/data/shared_providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'app.dart';

MultiProvider provideInjection() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: const MyApp(),
  );
}
