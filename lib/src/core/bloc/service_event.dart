import 'package:photo_me/src/domain/response/user/user_response.dart';

import '../../data/model/service_model.dart';

abstract class ServiceEvent {}

class SetServiceModel extends ServiceEvent {
  ServiceModel serviceModel;

  SetServiceModel(this.serviceModel);
}

class UpdateUserEvent extends ServiceEvent {
  UserResponse user;

  UpdateUserEvent(this.user);
}
