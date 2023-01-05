import 'package:clerkship/data/network/services/user_service.dart';
import 'package:flutter/cupertino.dart';

import '../../main.dart';
import '../network/entity/user_response.dart';

class UserProvider extends ChangeNotifier {
  final userService = getIt<UserService>();
  final List<User> preseptor = [];

  void getPreseptor({
    required int departemenId,
  }) async {
    final result =
        await userService.getAllUser(role: 1, idFeature: departemenId);

    if (result.statusCode == 200) {
      preseptor.clear();
      preseptor.addAll(result.data!.data!);
      notifyListeners();
    }
  }
}
