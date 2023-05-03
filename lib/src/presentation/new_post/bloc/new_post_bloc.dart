import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/main.dart';
import 'package:photo_me/src/presentation/new_post/bloc/new_post_event.dart';
import 'package:photo_me/src/presentation/new_post/bloc/new_post_state.dart';

import '../../../domain/api_service/api_service.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  NewPostBloc() : super(InitState()) {
    on<CreatePostEvent>((event, emit) => createPost(event, emit));
  }

  Future createPost(CreatePostEvent event, Emitter emit) async {
    // try {
    emit(NewPostLoading());
    ApiService apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    // final prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token") ?? "";
    final response = await apiService.createPost(
      "Bearer $token",
      {"description": event.description, "photo": []},
    );
    emit(NewPostSuccess());
    // } on DioError catch (e) {
    //   String error =
    //       e.response != null ? e.response!.data.toString() : e.toString();
    //   emit(NewPostError(error));
    //   print(error);
    // } catch (e) {
    //   emit(NewPostError(e.toString()));
    //   print(e);
    // }
  }
}
