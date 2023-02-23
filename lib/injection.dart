import 'package:provider/provider.dart';

import 'app.dart';
import 'data/network/services/auth_service.dart';
import 'data/network/services/clinic_activity_lecture_service.dart';
import 'data/network/services/clinic_activity_service.dart';
import 'data/network/services/reference_service.dart';
import 'data/network/services/scientific_activity_service.dart';
import 'data/network/services/scientific_event_lecture_service.dart';
import 'data/network/services/scoring_lecture_service.dart';
import 'data/network/services/standard_competency_service.dart';
import 'data/network/services/standart_competency_lecture_service.dart';
import 'data/network/services/user_service.dart';
import 'data/shared_providers/auth_provider.dart';
import 'data/shared_providers/clinic_activity_provider.dart';
import 'data/shared_providers/reference_provider.dart';
import 'data/shared_providers/scientific_provider.dart';
import 'data/shared_providers/standard_competency_provider.dart';
import 'data/shared_providers/user_provider.dart';
import 'main.dart';
import 'ui/screens/clinic_activity/providers/clinic_activity_lecture_provider.dart';
import 'ui/screens/clinic_activity/providers/item_list_all_provider.dart';
import 'ui/screens/clinic_activity/providers/item_list_approve_provider.dart';
import 'ui/screens/clinic_activity/providers/item_list_draft_provider.dart';
import 'ui/screens/clinic_activity/providers/item_list_reject_provider.dart';
import 'ui/screens/final_assessment/providers/final_assessment_lecture_provider.dart';
import 'ui/screens/final_assessment_detail/provider/final_assessment_detail_provider.dart';
import 'ui/screens/global_rating/provider/rating_assessment_provider.dart';
import 'ui/screens/mini_cex_approval/provider/mini_cex_approval_provider.dart';
import 'ui/screens/scientific_event/providers/item_list_all_provider.dart';
import 'ui/screens/scientific_event/providers/item_list_approve_provider.dart';
import 'ui/screens/scientific_event/providers/item_list_draft_provider.dart';
import 'ui/screens/scientific_event/providers/item_list_reject_provider.dart';
import 'ui/screens/scientific_event/providers/scientific_event_lecture_provider.dart';
import 'ui/screens/scientific_event_approval/provider/scientific_event_approval_provider.dart';
import 'ui/screens/scientific_event_student_list/provider/scientific_event_student_provider.dart';
import 'ui/screens/standard_competency/provider/standart_competency_provider.dart';
import 'ui/screens/standart_competency_student_list/provider/standart_competency_lecture_provider.dart';

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
      ChangeNotifierProvider(create: (_) => MiniCexApprovalProvider()),
      ChangeNotifierProvider(create: (_) => ScientificEventStudentProvider()),
      ChangeNotifierProvider(
          create: (_) => StandartCompetencyLectureProvider()),
      ChangeNotifierProvider(create: (_) => ScientificEventLectureProvider()),
      ChangeNotifierProvider(create: (_) => ScientificEventApprovalProvider()),
      ChangeNotifierProvider(create: (_) => FinalAssessmentLectureProvider()),
      ChangeNotifierProvider(create: (_) => FinalAssessmentDetailProvder()),
      ChangeNotifierProvider(create: (_) => RatingAssessmentProvider()),
    ],
    child: const MyApp(),
  );
}

void injectService() {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<ReferenceService>(ReferenceService());
  getIt.registerSingleton<UserService>(UserService());
  getIt.registerSingleton<ClinicActivityService>(ClinicActivityService());
  getIt.registerSingleton<ScientificActivityService>(
      ScientificActivityService());
  getIt.registerSingleton<StandardCompetencyService>(
      StandardCompetencyService());
  getIt.registerSingleton<ClinicActivityLectureService>(
      ClinicActivityLectureService());
  getIt.registerSingleton<ScientificEventLectureService>(
      ScientificEventLectureService());
  getIt.registerSingleton<StandartCompetencyLectureService>(
      StandartCompetencyLectureService());
  getIt.registerSingleton<ScoringLectureService>(ScoringLectureService());
}
