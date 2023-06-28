import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:photo_me/src/presentation/notification/bloc/notification_event.dart';
import 'package:photo_me/src/presentation/notification/bloc/notification_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service/api_service.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(InitState()) {
    on<Init>((event, emit) => init(emit));
    on<ReadNotify>((event, emit) => readNotify(emit, event.idNotify));
  }

  Future readNotify(Emitter emit, String idNotify) async{
    try{
      ApiService apiService =
      ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response =
      await apiService.readNotification(idNotify);
     // init(emit);
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

  Future init(Emitter emit) async {
    try {
      emit(Loading());
      final prefs = await SharedPreferences.getInstance();
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));

      String userID = prefs.getString("userID") ?? "";
      String token = prefs.getString("token") ?? "";
      print(userID + token);
      final response =
          await apiService.getAllNotification("Bearer $token", userID);
      print(response.data);
      emit(LoadingSuccess(response.data));
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
