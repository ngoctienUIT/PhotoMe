import 'package:dio/dio.dart';
import 'package:photo_me/src/domain/response/auth/auth_response.dart';
import 'package:photo_me/src/domain/response/comment/comment_response.dart';
import 'package:photo_me/src/domain/response/notification/notification_response.dart';
import 'package:photo_me/src/domain/response/post/post_response.dart';
import 'package:photo_me/src/domain/response/user/user_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

//flutter pub run build_runner build
@RestApi(baseUrl: 'http://192.168.0.113:5000')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  //sign up
  @POST("/api/user/signup")
  Future<HttpResponse<AuthResponse>> signup(@Body() Map<String, String> user);

  //login
  @POST("/api/user/login")
  Future<HttpResponse<AuthResponse>> login(@Body() Map<String, dynamic> user);

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
  Future<HttpResponse> followUser(
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
  @DELETE("/api/post/{id}")
  Future<HttpResponse> deletePostByID(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  //likePost
  @POST("/api/post/like")
  Future<HttpResponse> likePost(
    @Header('Authorization') String token,
    @Body() body,
  );

  //commentPost
  @POST("/api/comment/{id}")
  Future<HttpResponse> commentPost(
    @Path("id") String id,
    @Header('Authorization') String token,
    @Body() body,
  );

  //likeComment
  @POST("/api/comment/like")
  Future<HttpResponse> likeComment(
    @Header('Authorization') String token,
    @Body() body,
  );

  //deleteComment
  @DELETE("/api/comment/{id}")
  Future<HttpResponse> deleteComment(
    @Path("id") String id,
    @Header('Authorization') String token,
  );

  //getAllPost
  @GET("/api/post")
  Future<HttpResponse<List<PostResponse>>> getAllPost();

  //getAllPost
  @GET("/api/post/{id}")
  Future<HttpResponse<PostResponse>> getPostByID(@Path("id") String id);

  //getAllCommentPost
  @GET("/api/comment/{id}")
  Future<HttpResponse<List<CommentResponse>>> getAllCommentPost(
      @Path("id") String id);

  // get All notification
  @GET("/api/user/{id}/notification")
  Future<HttpResponse<List<NotificationHmResponse>>> getAllNotification(
      @Header('Authorization') String token, @Path("id") String id);

  // set device token
  @PUT("/api/user/{id}/deviceToken")
  Future<HttpResponse> setDeviceToken(
    @Header('Authorization') String token,
    @Path("id") String id,
    @Body() Map<String, String> body,
  );

  @GET("/api/user/{id}/deviceToken")
  Future<HttpResponse> getDeviceToken(
    @Header('Authorization') String token,
    @Path("id") String id,
  );
}
