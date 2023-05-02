import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_event.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_state.dart';

import '../../../domain/api_service/api_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getDataUser(emit));
  }

  Future getDataUser(Emitter emit) async {
    try {
      emit(ProfileLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      // final prefs = await SharedPreferences.getInstance();
      // String userID = prefs.getString("userID") ?? "";
      String userID = "644e6a86a80a852835987bd7";
      final userResponse = apiService.getUserByID(userID);
      final postResponse = apiService.getPostUser(userID);

      emit(ProfileLoaded((await userResponse).data, (await postResponse).data));
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
