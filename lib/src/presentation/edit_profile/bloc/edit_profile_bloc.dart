import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/domain/firebase_service/firebase_service.dart';
import 'package:photo_me/src/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:photo_me/src/presentation/edit_profile/bloc/edit_profile_state.dart';

import '../../../data/model/service_model.dart';
import '../../../data/model/user.dart';
import '../../../domain/api_service/api_service.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  ServiceModel serviceModel;

  EditProfileBloc(this.serviceModel) : super(InitState()) {
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
      print(user.avatar);
      if (user.avatar.isNotEmpty) {
        user.avatar = (await FirebaseService.uploadImage(
            [user.avatar], serviceModel.user!.id, "avatar"))[0];
      }
      final response = await apiService.updateUserByID(
          serviceModel.user!.id, "Bearer ${serviceModel.token}", user.toJson());
      emit(UpdateSuccess(response.data));
    } on DioException catch (e) {
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
