import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/network/entity/scientific_response.dart';
import '../../../../data/network/services/scientific_activity_service.dart';
import '../../../../main.dart';

class ItemListRejectScientificProvider extends ChangeNotifier {
  final clinicActivityService = getIt<ScientificActivityService>();
  final List<Scientific> listScientific = [];
  bool loading = false;

  ItemListRejectScientificProvider() {
    getListScientific();
  }

  void getListScientific() async {
    loading = true;
    notifyListeners();
    final result =
        await clinicActivityService.getListScientific(status: 9, idFlow: 2);

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
