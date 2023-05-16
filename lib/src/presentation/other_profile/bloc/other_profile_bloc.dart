import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service/api_service.dart';
import 'other_profile_event.dart';
import 'other_profile_state.dart';

class OtherProfileBloc extends Bloc<OtherProfileEvent, OtherProfileState> {
  OtherProfileBloc() : super(InitState()) {
    on<GetDataUser>((event, emit) => getDataUser(event.id, emit));

    on<UpdateDataUser>((event, emit) => updateDataUser(event.id, emit));

    on<GetDataPost>((event, emit) => getDataPostUser(event.id, emit));

    on<FollowUser>((event, emit) => followUser(event.id, emit));
  }

  Future getDataUser(String id, Emitter emit) async {
    try {
      emit(OtherProfileLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final userResponse = await apiService.getUserByID(id);

      emit(OtherProfileLoaded(userResponse.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(OtherProfileError(error));
      print(error);
    } catch (e) {
      emit(OtherProfileError(e.toString()));
      print(e);
    }
  }

  Future updateDataUser(String id, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final userResponse = await apiService.getUserByID(id);

      emit(OtherProfileLoaded(userResponse.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(OtherProfileError(error));
      print(error);
    } catch (e) {
      emit(OtherProfileError(e.toString()));
      print(e);
    }
  }

  Future getDataPostUser(String id, Emitter emit) async {
    try {
      emit(PostLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final postResponse = await apiService.getPostUser(id);

      emit(PostLoaded(postResponse.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(OtherProfileError(error));
      print(error);
    } catch (e) {
      emit(OtherProfileError(e.toString()));
      print(e);
    }
  }

  Future followUser(String id, Emitter emit) async {
    try {
      emit(FollowLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.followUser("Bearer $token", {"id_User": id});

      emit(FollowSuccess());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(OtherProfileError(error));
      print(error);
    } catch (e) {
      emit(OtherProfileError(e.toString()));
      print(e);
    }
  }
}
