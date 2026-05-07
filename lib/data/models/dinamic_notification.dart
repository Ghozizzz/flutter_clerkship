import '../network/entity/notification_response.dart';

class DinamicNotification {
  String title;
  List<Notifications>? notif;

  DinamicNotification({
    required this.title,
    this.notif,
  });
}
