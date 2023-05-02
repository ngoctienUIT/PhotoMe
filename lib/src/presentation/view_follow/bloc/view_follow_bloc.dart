import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/view_follow/bloc/view_follow_event.dart';
import 'package:photo_me/src/presentation/view_follow/bloc/view_follow_state.dart';

import '../../../../main.dart';
import '../../../domain/api_service/api_service.dart';

class ViewFollowBloc extends Bloc<ViewFollowEvent, ViewFollowState> {
  ViewFollowBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getDataFollow(emit));

    on<FollowEvent>((event, emit) => followUser(event.id, emit));
  }

  Future getDataFollow(Emitter emit) async {
    try {
      emit(ViewFollowLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      // final prefs = await SharedPreferences.getInstance();
      // String userID = prefs.getString("userID") ?? "";
      String userID = "644e6a86a80a852835987bd7";
      final followerResponse = apiService.getFollowerUser(userID);
      final followingResponse = apiService.getFollowingUser(userID);

      emit(ViewFollowLoaded(
        (await followerResponse).data,
        (await followingResponse).data,
      ));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ViewFollowError(error));
      print(error);
    } catch (e) {
      emit(ViewFollowError(e.toString()));
      print(e);
    }
  }

  Future followUser(String id, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      // final prefs = await SharedPreferences.getInstance();
      // String token = prefs.getString("token") ?? "";
      final response =
          await apiService.followUser("Bearer $token", {"id_User": id});

      String userID = "644e6a86a80a852835987bd7";
      final followerResponse = apiService.getFollowerUser(userID);
      final followingResponse = apiService.getFollowingUser(userID);

      emit(ViewFollowLoaded(
        (await followerResponse).data,
        (await followingResponse).data,
      ));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ViewFollowError(error));
      print(error);
    } catch (e) {
      emit(ViewFollowError(e.toString()));
      print(e);
    }
  }
}
