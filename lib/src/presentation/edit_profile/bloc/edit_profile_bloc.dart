import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:photo_me/src/presentation/edit_profile/bloc/edit_profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/user.dart';
import '../../../domain/api_service/api_service.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(InitState()) {
    on<UpdateProfileEvent>((event, emit) => updateProfile(event.user, emit));

    on<ChangeBirthDayEvent>((event, emit) => emit(ChangeBirthDayState()));

    on<ChangeGenderEvent>((event, emit) => emit(ChangeGenderState()));

    on<ChangeAvatarEvent>((event, emit) => emit(ChangeAvatarState()));
  }

  Future updateProfile(User user, Emitter emit) async {
    try {
      emit(UpdateLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String userID = prefs.getString("userID") ?? "";
      await apiService.updateUserByID(userID, "Bearer $token", user.toJson());
      emit(UpdateSuccess());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(UpdateError(error));
      print(error);
    } catch (e) {
      emit(UpdateError(e.toString()));
      print(e);
    }
  }
}
