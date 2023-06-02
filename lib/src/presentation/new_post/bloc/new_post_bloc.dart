import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/new_post/bloc/new_post_event.dart';
import 'package:photo_me/src/presentation/new_post/bloc/new_post_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service/api_service.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  NewPostBloc() : super(InitState()) {
    on<CreatePostEvent>((event, emit) => createPost(event, emit));

    on<UpdatePostEvent>((event, emit) => updatePost(event, emit));
  }

  Future createPost(CreatePostEvent event, Emitter emit) async {
    try {
      emit(NewPostLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      final response = await apiService.createPost(
        "Bearer $token",
        {"description": event.description, "photo": []},
      );
      print(response.data);
      if (event.photo.isNotEmpty) {
        final imageList =
            await uploadImage(event.photo, response.data.replaceAll('"', ""));
        await apiService.updatePost(
          "Bearer $token",
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
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      if (event.photo.isNotEmpty) {
        final imageList = await uploadImage(event.photo, event.id);
        await apiService.updatePost(
          "Bearer $token",
          event.id,
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

  Future<List<String>> uploadImage(List<String> list, String id) async {
    Reference reference = FirebaseStorage.instance.ref();
    List<String> listURL = [];
    for (var item in list) {
      if (!item.contains("https://") && !item.contains("http://")) {
        Reference upload =
            reference.child("post/$id/${DateTime.now().microsecond}");
        final result = await upload.putFile(File(item));
        print(result.ref.fullPath);
        listURL.add(await upload.getDownloadURL());
      } else {
        listURL.add(item);
      }
    }
    return listURL;
  }
}
