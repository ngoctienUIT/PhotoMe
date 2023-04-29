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

  //fetchDataProfile
  @GET("/api/profile?id_User={id}")
  Future<HttpResponse> fetchDataProfile(@Path("id") String id);

  //fetchAllDataProfile
  @GET("/api/profile")
  Future<HttpResponse> fetchAllDataProfile();

  //fetchMyAvatar
  @GET("/api/profile?id_User={id}")
  Future<HttpResponse> fetchMyAvatar(@Path("id") String id);

  //getAllPosts
  @GET("/api/newfeed/home")
  Future<HttpResponse> getAllPosts();

  //checkUserReactPost
  @GET("/api/profile?id_User={id}")
  Future<HttpResponse> checkUserReactPost(@Path("id") String id);

  //getAllMindPost
  @GET("/api/newfeed?id_User={id}")
  Future<HttpResponse> getAllMindPost(@Path("id") String id);

  //getThisPost
  @GET("/api/newfeed/thispost?id_Newfeed={id}")
  Future<HttpResponse> getThisPost(@Path("id") String id);

  //UpdateLikePost
  @POST("/api/liked/updateliked")
  Future<HttpResponse> updateLikePost(@Body() body);

  //createNewPost
  @POST("/api/newfeed")
  Future<HttpResponse> createNewPost(@Body() body);

  //deletePost
  @POST("/api/newfeed/deletenewfeed")
  Future<HttpResponse> deletePost(@Body() body);

  //fetchComment
  @GET("/api/comment?id_Newfeed={id}")
  Future<HttpResponse> fetchComment(@Path("id") String id);

  //fetchLiked
  @GET("/api/comment?id_User={id_User}&id_Newfeed={id_Newfeed}")
  Future<HttpResponse> fetchLiked(
    @Path("id_User") String idUser,
    @Path("id_Newfeed") String idNewFeed,
  );

  //uploadComment
  @POST("/api/comment")
  Future<HttpResponse> uploadComment(@Body() body);

  //deleteComment
  @POST("/api/comment/deletecomment")
  Future<HttpResponse> deleteComment(@Body() body);

  //fetchFollow
  @GET("/api/follow?id_User={id}")
  Future<HttpResponse> fetchFollow(@Path("id") String id);

  //activeFollow
  @POST("/api/profile/updatefollow/follow")
  Future<HttpResponse> activeFollow(@Body() body);

  //activeUnfollow
  @POST("/api/profile/updatefollow/unfollow")
  Future<HttpResponse> activeUnfollow(@Body() body);

  //getFollowingById
  @GET("/api/follow?id_User={id}")
  Future<HttpResponse> getFollowingById(@Path("id") String id);

  //getFollowerById
  @GET("/api/follow?id_User={id}")
  Future<HttpResponse> getFollowerById(@Path("id") String id);
}
