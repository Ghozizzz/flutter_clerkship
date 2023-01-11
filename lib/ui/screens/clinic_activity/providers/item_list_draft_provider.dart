import 'package:flutter/cupertino.dart';

import '../../../../data/network/entity/clinic_response.dart';
import '../../../../data/network/services/clinic_activity_service.dart';
import '../../../../main.dart';

class ItemListDraftClinicProvider extends ChangeNotifier {
  final clinicActivityService = getIt<ClinicActivityService>();
  final List<Clinic> listClinic = [];

  ItemListDraftClinicProvider() {
    getListClinic();
  }

  void getListClinic() async {
    final result = await clinicActivityService.getListClinic(status: 0);

    if (result.statusCode == 200) {
      listClinic.clear();
      listClinic.addAll(result.data!.data!.list!);
      notifyListeners();
    }
  }
}
