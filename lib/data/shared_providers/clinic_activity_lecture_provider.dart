import 'package:clerkship/data/network/services/clinic_activity_lecture_service.dart';
import 'package:clerkship/main.dart';
import 'package:flutter/material.dart';

class ClinicActivityLectureProvider extends ChangeNotifier {
  final clinicActivityLectureService = getIt<ClinicLectureService>();
}
