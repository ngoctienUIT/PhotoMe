import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/home/bloc/home_event.dart';
import 'package:photo_me/src/presentation/home/bloc/home_state.dart';

import '../../../domain/api_service/api_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(HomeLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllPost();
      emit(HomeLoaded(response.data.reversed.toList()));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(HomeError(error));
      print(error);
    } catch (e) {
      emit(HomeError(e.toString()));
      print(e);
    }
  }
}
