import 'package:dio/dio.dart';
import 'package:photo_me/src/domain/response/post/post_response.dart';
import 'package:photo_me/src/domain/response/user/user_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

//flutter pub run build_runner build
@RestApi(baseUrl: 'http://192.168.1.6:5000')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  //sign up
  @POST("/api/user/signup")
  Future<HttpResponse> signup(@Body() Map<String, dynamic> user);

  //login
  @POST("/api/user/login")
  Future<HttpResponse> login(@Body() Map<String, dynamic> user);

  //getUserByID
  @GET("/api/user/{id}")
  Future<HttpResponse<UserResponse>> getUserByID(@Path("id") String id);

  //searchUserByName
  @GET("/api/user/search?name={query}")
  Future<HttpResponse<List<UserResponse>>> searchUserByName(
      @Path("query") String query);

  //updateUserByID
  @PUT("/api/user/{id}")
  Future<HttpResponse> updateUserByID(
    @Path("id") String id,
    @Header('Authorization') String token,
    @Body() body,
  );

  //getPostUser
  @GET("/api/user/{id}/post")
  Future<HttpResponse<List<PostResponse>>> getPostUser(@Path("id") String id);

  //getFollowingUser
  @GET("/api/user/{id}/following")
  Future<HttpResponse<List<UserResponse>>> getFollowingUser(
      @Path("id") String id);

  //getFollowerUser
  @GET("/api/user/{id}/follower")
  Future<HttpResponse<List<UserResponse>>> getFollowerUser(
      @Path("id") String id);

  //followUser
  @POST("/api/user/follow")
  Future<HttpResponse<List<UserResponse>>> followUser(
    @Header('Authorization') String token,
    @Body() body,
  );

  //createPost
  @POST("/api/post")
  Future<HttpResponse> createPost(
    @Header('Authorization') String token,
    @Body() body,
  );

  //deletePostByID
  @POST("/api/post/{id}")
  Future<HttpResponse> deletePostByID(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  //getAllPost
  @GET("/api/post")
  Future<HttpResponse<List<PostResponse>>> getAllPost();
}
