

import '../../../domain/response/notification/notification_response.dart';

abstract class NotificationState {}

class InitState extends NotificationState {}

class Loading extends NotificationState {}

class LoadingSuccess extends NotificationState {
  List<NotificationHmResponse> notifications;

  LoadingSuccess(this.notifications);
}

class ErrorState extends NotificationState {
  String error;

  ErrorState(this.error);
}
