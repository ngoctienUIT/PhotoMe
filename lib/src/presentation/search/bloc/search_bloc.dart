import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/search/bloc/search_event.dart';
import 'package:photo_me/src/presentation/search/bloc/search_state.dart';


import '../../../domain/api_service/api_service.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitState()) {
    on<Search>((event, emit) => getData(emit, event.searchText));
  }

  Future getData(Emitter emit, String searchText) async {
    print("letgo");
    try {
      emit(SearchLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      print("object");
      final response = await apiService.searchUserByName(searchText);
      print(response.data);
      emit(SearchSuccess(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(SearchError(error));
      print(error);
    } catch (e) {
      emit(SearchError(e.toString()));
      print(e);
    }
  }
}
