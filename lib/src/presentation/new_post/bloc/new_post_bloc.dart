import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/domain/firebase_service/firebase_service.dart';
import 'package:photo_me/src/presentation/new_post/bloc/new_post_event.dart';
import 'package:photo_me/src/presentation/new_post/bloc/new_post_state.dart';

import '../../../data/model/service_model.dart';
import '../../../domain/api_service/api_service.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  ServiceModel serviceModel;

  NewPostBloc(this.serviceModel) : super(InitState()) {
    on<CreatePostEvent>((event, emit) => createPost(event, emit));

    on<UpdatePostEvent>((event, emit) => updatePost(event, emit));

    on<ChangeImageListEvent>((event, emit) => emit(ChangeImageListState()));
  }

  Future createPost(CreatePostEvent event, Emitter emit) async {
    try {
      emit(NewPostLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.createPost(
        "Bearer ${serviceModel.token}",
        {"description": event.description, "photo": []},
      );
      print(response.data);
      if (event.photo.isNotEmpty) {
        final imageList = await FirebaseService.uploadImage(
            event.photo, response.data.replaceAll('"', ""));
        await apiService.updatePost(
          "Bearer ${serviceModel.token}",
          response.data.replaceAll('"', ""),
          {"description": event.description, "photo": imageList},
        );
      }
      emit(NewPostSuccess());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(NewPostError(error));
      print(error);
    } catch (e) {
      emit(NewPostError(e.toString()));
      print(e);
    }
  }

  Future updatePost(UpdatePostEvent event, Emitter emit) async {
    try {
      emit(NewPostLoading());
      for (var item in event.deletePhoto) {
        FirebaseService.deleteImage(item);
      }
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final imageList =
          await FirebaseService.uploadImage(event.photo, event.id);
      await apiService.updatePost(
        "Bearer ${serviceModel.token}",
        event.id,
        {"description": event.description, "photo": imageList},
      );
      emit(NewPostSuccess());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(NewPostError(error));
      print(error);
    } catch (e) {
      emit(NewPostError(e.toString()));
      print(e);
    }
  }
}
