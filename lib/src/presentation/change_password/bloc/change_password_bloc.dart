import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/service_model.dart';
import '../../../domain/api_service/api_service.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ServiceModel serviceModel;

  ChangePasswordBloc(this.serviceModel) : super(InitState()) {
    on<ClickChangePasswordEvent>(
        (event, emit) => changePassword(event.password, emit));

    on<ShowChangeButtonEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<HidePasswordEvent>(
        (event, emit) => emit(HidePasswordState(isHide: event.isHide)));

    on<TextChangeEvent>((event, emit) => emit(TextChangeState()));
  }

  Future changePassword(String password, Emitter emit) async {
    try {
      emit(ChangePasswordLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.updatePassword(
          "Bearer ${serviceModel.token}", {"password": password});
      emit(ChangePasswordSuccessState(response.data['data']));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ChangePasswordErrorState(status: error));
      print(error);
    } catch (e) {
      emit(ChangePasswordErrorState(status: e.toString()));
      print(e);
    }
  }
}
