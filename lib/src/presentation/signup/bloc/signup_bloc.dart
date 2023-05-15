import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/signup/bloc/signup_event.dart';
import 'package:photo_me/src/presentation/signup/bloc/signup_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service/api_service.dart';

class SignupBloc extends Bloc<SignupScreenEvent, SignupState> {
  SignupBloc() : super(InitState()) {
    on<Signup>((event, emit) => login(event.email, event.password, emit));
  }

  Future login(String email, String password, Emitter emit) async {
    try {
      emit(SignupLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response =
          await apiService.login({"email": email, "password": password});
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", response.data.token);
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupError(e.toString()));
    }
  }
}
