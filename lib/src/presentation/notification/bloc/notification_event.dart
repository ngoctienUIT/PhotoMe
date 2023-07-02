import '../../../domain/response/notification/notification_response.dart';

abstract class NotificationEvent {}

class Init extends NotificationEvent {
  Init();
}
class ReadNotify extends NotificationEvent {
  final String idNotify;
  final  List<NotificationHmResponse> notifications;
  ReadNotify(this.idNotify, this.notifications);
}
