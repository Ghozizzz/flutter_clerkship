import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/network/entity/clinic_doctor_response.dart';
import '../../../../data/network/services/clinic_activity_lecture_service.dart';
import '../../../../main.dart';

class ItemListRateClinicLectureProvider extends ChangeNotifier {
  final clinicActivityLectureService = getIt<ClinicLectureService>();
  final List<ClinicDoctorTglData> data = [];
  bool loading = false;

  void getClinicActivityLecture({
    int? idFeature,
    DateTime? date,
  }) async {
    loading = true;
    notifyListeners();
    final result = await clinicActivityLectureService.getListClinicLecture(
      status: 2,
      idFeature: idFeature,
      date: date,
    );
    if (result.statusCode == 200) {
      data.clear();
      data.addAll(result.data!.data!);
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: result.data!.message!);
    }

    loading = false;
    notifyListeners();
  }
}
