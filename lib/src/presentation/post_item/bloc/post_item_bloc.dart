import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/post_item/bloc/post_item_event.dart';
import 'package:photo_me/src/presentation/post_item/bloc/post_item_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service/api_service.dart';

class PostItemBloc extends Bloc<PostItemEvent, PostItemState> {
  PostItemBloc() : super(InitState()) {
    on<LikePostEvent>((event, emit) => likePost(event.id, emit));

    on<FollowUserEvent>((event, emit) => followUser(event.id, emit));

    on<DeletePostEvent>((event, emit) => deletePost(event.id, emit));
  }

  Future likePost(String id, Emitter emit) async {
    try {
      emit(LikeLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.likePost("Bearer $token", {"id_Post": id});
      emit(LikeSuccess());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ErrorState(error));
      print(error);
    } catch (e) {
      emit(ErrorState(e.toString()));
      print(e);
    }
  }

  Future followUser(String id, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.followUser("Bearer $token", {"id_User": id});
      emit(FollowSuccess());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ErrorState(error));
      print(error);
    } catch (e) {
      emit(ErrorState(e.toString()));
      print(e);
    }
  }

  Future deletePost(String id, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.deletePostByID("Bearer $token", id);
      emit(DeleteSuccess());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ErrorState(error));
      print(error);
    } catch (e) {
      emit(ErrorState(e.toString()));
      print(e);
    }
  }
}
