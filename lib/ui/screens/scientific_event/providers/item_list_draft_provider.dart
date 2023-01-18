import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/network/entity/clinic_response.dart';
import '../../../../data/network/services/clinic_activity_service.dart';
import '../../../../main.dart';

class ItemListDraftScientificProvider extends ChangeNotifier {
  final clinicActivityService = getIt<ClinicActivityService>();
  final List<Clinic> listScientific = [];
  bool loading = false;

  ItemListDraftScientificProvider() {
    getListScientific();
  }

  void getListScientific() async {
    loading = true;
    notifyListeners();
    final result =
        await clinicActivityService.getListClinic(status: 0, idFlow: 2);

    if (result.statusCode == 200) {
      listScientific.clear();
      listScientific.addAll(result.data!.data!.list!);
    } else {
      Fluttertoast.showToast(msg: result.data!.message!);
    }
    loading = false;
    notifyListeners();
  }
}
