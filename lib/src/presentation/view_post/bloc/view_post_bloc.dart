import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/view_post/bloc/view_post_event.dart';
import 'package:photo_me/src/presentation/view_post/bloc/view_post_state.dart';

import '../../../data/model/service_model.dart';
import '../../../domain/api_service/api_service.dart';

class ViewPostBloc extends Bloc<ViewPostEvent, ViewPostState> {
  ServiceModel serviceModel;

  ViewPostBloc(this.serviceModel) : super(InitState()) {
    on<GetComment>((event, emit) => getAllCommentPost(event.id, emit));

    on<GetPost>((event, emit) => getPost(event.id, emit));

    on<CommentPost>((event, emit) => commentPost(event, emit));

    on<ReplyComment>((event, emit) => replyComment(event, emit));

    on<GetReplyComment>((event, emit) => getReplyComment(event.id, emit));

    on<WriteComment>((event, emit) => emit(WriteCommentState(event.check)));

    on<LikeComment>((event, emit) => likeComment(event.id, emit));

    on<DeleteComment>((event, emit) => deleteComment(event, emit));

    on<ChangeCommentEvent>((event, emit) => emit(ChangeCommentState()));
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
      await apiService.commentPost(
          event.id, "Bearer ${serviceModel.token}", {"comment": event.comment});
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

  Future replyComment(ReplyComment event, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      await apiService.replyComment(event.idComment,
          "Bearer ${serviceModel.token}", {"comment": event.comment});
      final response = await apiService.getAllReplyComment(event.idComment);
      add(GetPost(event.idPost));
      add(GetComment(event.idPost));
      emit(GetReplySuccess(event.idComment, response.data));
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

  Future getReplyComment(String id, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllReplyComment(id);
      emit(GetReplySuccess(id, response.data));
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
      await apiService
          .likeComment("Bearer ${serviceModel.token}", {"id_comment": id});
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
      await apiService.deleteComment(
          event.idComment, "Bearer ${serviceModel.token}");
      emit(DeleteCommentSuccess(event.idComment));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      // add(GetPost(event.idPost));
      emit(ErrorState(error));
      print(error);
    } catch (e) {
      emit(ErrorState(e.toString()));
      print(e);
    }
  }
}
