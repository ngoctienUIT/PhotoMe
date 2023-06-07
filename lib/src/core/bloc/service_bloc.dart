import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/core/bloc/service_event.dart';
import 'package:photo_me/src/core/bloc/service_state.dart';

import '../../data/model/service_model.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceModel serviceModel = ServiceModel();

  ServiceBloc() : super(InitState()) {
    on<SetServiceModel>(
        (event, emit) => serviceModel = event.serviceModel.copyWith());
  }
}
