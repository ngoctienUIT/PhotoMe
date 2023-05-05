import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/view_post/bloc/view_post_event.dart';
import 'package:photo_me/src/presentation/view_post/bloc/view_post_state.dart';

import '../../../../main.dart';
import '../../../domain/api_service/api_service.dart';

class ViewPostBloc extends Bloc<ViewPostEvent, ViewPostState> {
  ViewPostBloc() : super(InitState()) {
    on<GetComment>((event, emit) => getAllCommentPost(event.id, emit));

    on<GetPost>((event, emit) => getPost(event.id, emit));

    on<CommentPost>((event, emit) => commentPost(event, emit));

    on<WriteComment>((event, emit) => emit(WriteCommentState(event.check)));
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
}
