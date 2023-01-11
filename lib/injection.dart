import 'package:clerkship/data/shared_providers/clinic_activity_provider.dart';
import 'package:clerkship/data/shared_providers/reference_provider.dart';
import 'package:clerkship/data/shared_providers/user_provider.dart';
import 'package:clerkship/ui/screens/clinic_activity/providers/item_list_all_provider.dart';
import 'package:clerkship/ui/screens/clinic_activity/providers/item_list_approve_provider%20copy.dart';
import 'package:clerkship/ui/screens/clinic_activity/providers/item_list_draft_provider.dart';
import 'package:clerkship/ui/screens/clinic_activity/providers/item_list_reject_provider.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'data/shared_providers/auth_provider.dart';

MultiProvider provideInjection() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => ReferenceProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ClinicActivityProvider()),
      ChangeNotifierProvider(create: (_) => ItemListAllClinicProvider()),
      ChangeNotifierProvider(create: (_) => ItemListDraftClinicProvider()),
      ChangeNotifierProvider(create: (_) => ItemListApproveClinicProvider()),
      ChangeNotifierProvider(create: (_) => ItemListRejectClinicProvider()),
    ],
    child: const MyApp(),
  );
}
