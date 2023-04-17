import 'package:clerkship/ui/components/buttons/survey_score_button.dart';
import 'package:fleather/fleather.dart';
import 'package:clerkship/data/network/entity/survey_response.dart';
import 'package:clerkship/data/network/entity/survey_form_response.dart';
import 'package:clerkship/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../ui/components/buttons/dropdown_field.dart';
import '../network/services/survey_service.dart';

class SurveyProvider extends ChangeNotifier {
  final surveyService = getIt<SurveyService>();

  final List<SurveyList> surveyList = [];
  
  bool isloadingSurveyList = false;

  void getSurveyList() async {
    isloadingSurveyList = true;
    notifyListeners();
    final result = await surveyService.getSurveyList();
    if (result.statusCode == 200) {
      surveyList.clear();
      surveyList.addAll(result.data!.data!);
      isloadingSurveyList = false;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: result.data!.message!);
    }
  }
}
