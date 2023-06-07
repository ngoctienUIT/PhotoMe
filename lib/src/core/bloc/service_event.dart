import '../../data/model/service_model.dart';

abstract class ServiceEvent {}

class SetServiceModel extends ServiceEvent {
  ServiceModel serviceModel;

  SetServiceModel(this.serviceModel);
}
