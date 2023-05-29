import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/signup/bloc/signup_event.dart';
import 'package:photo_me/src/presentation/signup/bloc/signup_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service/api_service.dart';

class SignupBloc extends Bloc<SignupScreenEvent, SignupState> {
  SignupBloc() : super(InitState()) {
    on<Signup>(
      (event, emit) => signup(event.email, event.password, event.rePassword,
          event.gender, event.name, event.phone, emit),
    );
  }

  Future signup(
    String email,
    String password,
    String rePassword,
    String gender,
    String name,
    String phone,
    Emitter emit,
  ) async {
    try {
      emit(SignupLoading());
      if (password != rePassword) {
        emit(SignupError("Password not match"));
      }
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.signup({
        "email": email,
        "password": password,
        "gender": gender,
        "name": name,
        "phoneNumber": phone,
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", response.data.token);
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupError(e.toString()));
    }
  }
}
