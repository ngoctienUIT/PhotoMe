import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_event.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_state.dart';

import '../../../data/model/service_model.dart';
import '../../../domain/api_service/api_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ServiceModel serviceModel;

  ProfileBloc(this.serviceModel) : super(InitState()) {
    on<GetProfileData>((event, emit) => getDataUser(emit));

    on<GetPostData>((event, emit) => getPostDataUser(emit));
  }

  Future getDataUser(Emitter emit) async {
    try {
      emit(ProfileLoading());
      emit(ProfileLoaded(serviceModel.user!));
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      // String userID = "644e6a86a80a852835987bd7";
      final userResponse = await apiService.getUserByID(serviceModel.user!.id);
      if (userResponse.data != serviceModel.user) {
        emit(ProfileLoaded(userResponse.data));
      }
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ProfileError(error));
      print(error);
    } catch (e) {
      emit(ProfileError(e.toString()));
      print(e);
    }
  }

  Future getPostDataUser(Emitter emit) async {
    try {
      emit(PostLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      // String userID = "644e6a86a80a852835987bd7";
      final postResponse = await apiService.getPostUser(serviceModel.user!.id);

      emit(PostLoaded(postResponse.data.reversed.toList()));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ProfileError(error));
      print(error);
    } catch (e) {
      emit(ProfileError(e.toString()));
      print(e);
    }
  }
}
