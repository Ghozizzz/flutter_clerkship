import 'package:provider/provider.dart';

import 'app.dart';
import 'data/shared_providers/auth_provider.dart';

MultiProvider provideInjection() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: const MyApp(),
  );
}
