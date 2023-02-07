import 'package:provider/provider.dart';

import 'app.dart';
import 'data/shared_providers/auth_provider.dart';
import 'data/shared_providers/clinic_activity_provider.dart';
import 'data/shared_providers/reference_provider.dart';
import 'data/shared_providers/scientific_provider.dart';
import 'data/shared_providers/standard_competency_provider.dart';
import 'data/shared_providers/user_provider.dart';
import 'ui/screens/clinic_activity/providers/clinic_activity_lecture_provider.dart';
import 'ui/screens/clinic_activity/providers/item_list_all_provider.dart';
import 'ui/screens/clinic_activity/providers/item_list_approve_provider.dart';
import 'ui/screens/clinic_activity/providers/item_list_draft_provider.dart';
import 'ui/screens/clinic_activity/providers/item_list_reject_provider.dart';
import 'ui/screens/scientific_event/providers/item_list_all_provider.dart';
import 'ui/screens/scientific_event/providers/item_list_approve_provider.dart';
import 'ui/screens/scientific_event/providers/item_list_draft_provider.dart';
import 'ui/screens/scientific_event/providers/item_list_reject_provider.dart';
import 'ui/screens/standard_competency/provider/standart_competency_provider.dart';

MultiProvider provideInjection() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => ReferenceProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ClinicActivityProvider()),
      ChangeNotifierProvider(create: (_) => ScientificActivityProvider()),
      ChangeNotifierProvider(create: (_) => ItemListAllClinicProvider()),
      ChangeNotifierProvider(create: (_) => ItemListDraftClinicProvider()),
      ChangeNotifierProvider(create: (_) => ItemListApproveClinicProvider()),
      ChangeNotifierProvider(create: (_) => ItemListRejectClinicProvider()),
      ChangeNotifierProvider(create: (_) => ItemListAllScientificProvider()),
      ChangeNotifierProvider(create: (_) => ItemListDraftScientificProvider()),
      ChangeNotifierProvider(
          create: (_) => ItemListApproveScientificProvider()),
      ChangeNotifierProvider(create: (_) => ItemListRejectScientificProvider()),
      ChangeNotifierProvider(create: (_) => StandardCompetencyProvider()),
      ChangeNotifierProvider(create: (_) => StandartCompetencyProvider()),
      ChangeNotifierProvider(create: (_) => ClinicActivityLectureProvider()),
    ],
    child: const MyApp(),
  );
}
