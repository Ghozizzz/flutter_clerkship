import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/network/entity/clinic_response.dart';
import '../../../../data/network/services/clinic_activity_service.dart';
import '../../../../main.dart';

class ItemListRejectClinicProvider extends ChangeNotifier {
  final clinicActivityService = getIt<ClinicActivityService>();
  final List<Clinic> listClinic = [];
  bool loading = false;

  ItemListRejectClinicProvider() {
    getListClinic();
  }

  void getListClinic() async {
    loading = true;
    notifyListeners();
    final result = await clinicActivityService.getListClinic(status: 9);

    if (result.statusCode == 200) {
      listClinic.clear();
      listClinic.addAll(result.data!.data!.list!);
    } else {
      Fluttertoast.showToast(msg: result.data!.message!);
    }

    loading = false;
    notifyListeners();
  }
}
