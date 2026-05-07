import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';
import '../models/dinamic_notification.dart';
import '../network/entity/notification_response.dart';
import '../network/services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final notifService = getIt<NotificationService>();
  List<DinamicNotification> notifAll = [];
  Notifications lastNotif = Notifications();
  bool isLoadingNotif = false;
  int jumlahNotif = 0;

  Future getNotification({
    required int role,
  }) async {
    jumlahNotif = 0;
    isLoadingNotif = true;
    notifAll.clear();
    notifyListeners();
    final result = await notifService.getNotification(role: role);

    if (result.statusCode == 200) {
      jumlahNotif = result.data!.data!.jumlah!;

      if (result.data!.data!.other!.isNotEmpty) {
        lastNotif = result.data!.data!.other!.first;
        notifAll.add(DinamicNotification(
          title: 'Other',
          notif: result.data!.data!.other,
        ));
      }

      if (result.data!.data!.yesterday!.isNotEmpty) {
        lastNotif = result.data!.data!.yesterday!.first;
        notifAll.add(DinamicNotification(
          title: 'Yesterday',
          notif: result.data!.data!.yesterday,
        ));
      }

      if (result.data!.data!.today!.isNotEmpty) {
        lastNotif = result.data!.data!.today!.first;
        notifAll.add(DinamicNotification(
          title: 'Today',
          notif: result.data!.data!.today,
        ));
      }
      notifAll = notifAll.reversed.toList();
      isLoadingNotif = false;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: result.data?.message ?? '');
    }
  }

  void readNotification() async {
    final result = await notifService.readNotification();

    if (result.statusCode == 200) {
      jumlahNotif = 0;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: result.data?.message ?? '');
    }
  }
}
