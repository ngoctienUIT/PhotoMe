import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/login/bloc/login_event.dart';
import 'package:photo_me/src/presentation/login/bloc/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service/api_service.dart';

class LoginBloc extends Bloc<LoginScreenEvent, LoginState> {
  LoginBloc() : super(InitState()) {
    on<Init>((event, emit) => init(emit));
    on<Login>((event, emit) => login(event.email, event.password, emit));
  }

  Future login(String email, String password, Emitter emit) async {
    try {
      emit(LoginLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response =
          await apiService.login({"email": email, "password": password});

      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", response.data.token);
      prefs.setString("userID", response.data.user.id);

      print("token: ${response.data.token}");

      final deviceToken = await FirebaseMessaging.instance.getToken() ?? "";

      print(deviceToken);

      print(response.data.user.id);

      final deviceTokenResponse = await apiService.setDeviceToken(
        "Bearer ${response.data.token}",
        response.data.user.id,
        {"deviceToken": deviceToken},
      );


      print("ok?");

      // print(deviceTokenResponse.data.deviceToken);
      emit(LoginSuccess(userID: response.data.user.id));
    } catch (e) {
      print(e);
      emit(LoginError(e.toString()));
    }
  }

  Future init(Emitter emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String userID = prefs.getString("userID") ?? "";
      if (token.isNotEmpty && userID.isNotEmpty) {
        print(token);
        emit(LoginSuccess(userID: userID));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
      print(e);
    }
  }
}
