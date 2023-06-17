import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/service_model.dart';
import '../../../domain/api_service/api_service.dart';
import 'setting_event.dart';
import 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  ServiceModel serviceModel;

  SettingBloc(this.serviceModel) : super(InitState()) {
    on<DeleteUserEvent>((event, emit) => deleteUser(emit));
  }

  Future deleteUser(Emitter emit) async {
    try {
      emit(LoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      await apiService.deleteUser(
          "Bearer ${serviceModel.token}", serviceModel.user!.id);
      emit(SuccessState());
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ErrorState(error));
      print(error);
    } catch (e) {
      emit(ErrorState(e.toString()));
      print(e);
    }
  }
}
