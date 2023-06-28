abstract class NotificationEvent {}

class Init extends NotificationEvent {
  Init();
}
class ReadNotify extends NotificationEvent {
  final String idNotify;
  ReadNotify(this.idNotify);
}
