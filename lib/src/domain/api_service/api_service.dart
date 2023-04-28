import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

//flutter pub run build_runner build
@RestApi(baseUrl: 'http://192.168.1.6:5000')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  //sign up
  @POST("/api/user")
  Future<HttpResponse> signup(@Body() Map<String, dynamic> user);

  //login
  @POST("/api/login")
  Future<HttpResponse> login(@Body() Map<String, dynamic> user);
}
