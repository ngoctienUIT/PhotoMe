import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/view_follow/bloc/view_follow_event.dart';
import 'package:photo_me/src/presentation/view_follow/bloc/view_follow_state.dart';

import '../../../../main.dart';
import '../../../domain/api_service/api_service.dart';

class ViewFollowBloc extends Bloc<ViewFollowEvent, ViewFollowState> {
  ViewFollowBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getDataFollow(event.id, emit));

    on<FollowEvent>((event, emit) => followUser(event.id, emit));
  }

  Future getDataFollow(String id, Emitter emit) async {
    try {
      emit(ViewFollowLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final followerResponse = apiService.getFollowerUser(id);
      final followingResponse = apiService.getFollowingUser(id);

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
      await apiService.followUser("Bearer $token", {"id_User": id});
      final followerResponse = apiService.getFollowerUser(id);
      final followingResponse = apiService.getFollowingUser(id);

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
