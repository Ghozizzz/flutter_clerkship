import 'package:clerkship/data/network/entity/scientifc_event_participant_response.dart';
import 'package:flutter/foundation.dart';

import '../../../../data/network/services/scientific_event_lecture_service.dart';
import '../../../../main.dart';

class ScientificEventStudentProvider extends ChangeNotifier {
  final service = getIt<ScientificEventLectureService>();
  final participants = <ScientificEventParticipant>[];
  bool loading = true;

  Future getParticipant() async {
    loading = true;
    participants.clear();
    notifyListeners();

    final response = await service.getParticipant();

    participants.addAll(response.data?.data ?? []);
    loading = false;
    notifyListeners();
  }
}
