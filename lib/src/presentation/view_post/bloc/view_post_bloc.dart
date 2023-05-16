import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/view_post/bloc/view_post_event.dart';
import 'package:photo_me/src/presentation/view_post/bloc/view_post_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service/api_service.dart';

class ViewPostBloc extends Bloc<ViewPostEvent, ViewPostState> {
  ViewPostBloc() : super(InitState()) {
    on<GetComment>((event, emit) => getAllCommentPost(event.id, emit));

    on<GetPost>((event, emit) => getPost(event.id, emit));

    on<CommentPost>((event, emit) => commentPost(event, emit));

    on<WriteComment>((event, emit) => emit(WriteCommentState(event.check)));

    on<LikeComment>((event, emit) => likeComment(event.id, emit));

    on<DeleteComment>((event, emit) => deleteComment(event, emit));
  }

  Future getAllCommentPost(String id, Emitter emit) async {
    try {
      emit(CommentLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllCommentPost(id);

      emit(CommentSuccess(response.data));
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

  Future getPost(String id, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getPostByID(id);

      emit(PostSuccess(response.data));
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

  Future commentPost(CommentPost event, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService
          .commentPost(event.id, "Bearer $token", {"comment": event.comment});
      final response = await apiService.getAllCommentPost(event.id);
      add(GetPost(event.id));
      emit(CommentSuccess(response.data));
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

  Future likeComment(String id, Emitter emit) async {
    try {
      emit(LikeCommentLoading(id));
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.likeComment("Bearer $token", {"id_comment": id});
      emit(LikeCommentSuccess(id));
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

  Future deleteComment(DeleteComment event, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.deleteComment(event.idComment, "Bearer $token");
      emit(DeleteCommentSuccess());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      add(GetPost(event.idPost));
      emit(ErrorState(error));
      print(error);
    } catch (e) {
      emit(ErrorState(e.toString()));
      print(e);
    }
  }
}
