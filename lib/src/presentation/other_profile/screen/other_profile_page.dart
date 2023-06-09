import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/core/bloc/service_bloc.dart';
import 'package:photo_me/src/core/utils/extension/string_extension.dart';
import 'package:photo_me/src/presentation/other_profile/bloc/other_profile_bloc.dart';
import 'package:photo_me/src/presentation/other_profile/bloc/other_profile_event.dart';
import 'package:photo_me/src/presentation/other_profile/bloc/other_profile_state.dart';
import 'package:photo_me/src/presentation/profile/widgets/build_loading_profile.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../edit_profile/screen/edit_profile.dart';
import '../../profile/widgets/info_item.dart';
import '../../view_follow/screen/view_follow_page.dart';
import '../../view_post/screen/view_post_page.dart';

class OtherProfilePage extends StatelessWidget {
  const OtherProfilePage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtherProfileBloc()
        ..add(GetDataUser(id))
        ..add(GetDataPost(id)),
      child: OtherProfileView(id: id),
    );
  }
}

class OtherProfileView extends StatelessWidget {
  const OtherProfileView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtherProfileBloc, OtherProfileState>(
      listener: (context, state) {
        if (state is FollowSuccess) {
          context.read<OtherProfileBloc>().add(UpdateDataUser(id));
        }
      },
      child: Scaffold(
        appBar: AppBar(elevation: 0),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<OtherProfileBloc>().add(GetDataPost(id));
        context.read<OtherProfileBloc>().add(GetDataUser(id));
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(children: [buildInfo(), buildListPost()]),
      ),
    );
  }

  Widget buildInfo() {
    return BlocBuilder<OtherProfileBloc, OtherProfileState>(
      buildWhen: (previous, current) =>
          current is InitState ||
          current is OtherProfileLoading ||
          current is OtherProfileLoaded,
      builder: (context, state) {
        if (state is OtherProfileLoaded) {
          return Column(
            children: [
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(90),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: state.user.avatar,
                    height: 150,
                    width: 150,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/avatar.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                state.user.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              if (state.user.description != null &&
                  state.user.description!.isNotEmpty)
                const SizedBox(height: 5),
              if (state.user.description != null &&
                  state.user.description!.isNotEmpty)
                Text(state.user.description ?? ""),
              const SizedBox(height: 10),
              id == context.read<ServiceBloc>().serviceModel.user!.id
                  ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black54),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(createRoute(
                          screen: const EditProfile(),
                          begin: const Offset(0, 1),
                        ));
                      },
                      child: Text("edit_profile".translate(context)),
                    )
                  : buildButtonFollow(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  infoItem("post".translate(context), state.user.post!.length,
                      () {
                    customToast(context,
                        "${"number_of_posts_by".translate(context)} ${state.user.name}");
                  }),
                  infoItem("Followers", state.user.follower.length, () {
                    Navigator.of(context).push(createRoute(
                      screen: ViewFollowPage(index: 0, id: id),
                      begin: const Offset(1, 0),
                    ));
                  }),
                  infoItem("Following", state.user.following.length, () {
                    Navigator.of(context).push(createRoute(
                      screen: ViewFollowPage(index: 1, id: id),
                      begin: const Offset(1, 0),
                    ));
                  }),
                ],
              ),
              const SizedBox(height: 20),
            ],
          );
        }
        return buildLoadingHeader();
      },
    );
  }

  Widget buildButtonFollow() {
    List<String> initFollow = [];
    return BlocBuilder<OtherProfileBloc, OtherProfileState>(
      buildWhen: (previous, current) =>
          current is! PostLoading &&
          current is! PostLoaded &&
          current is! OtherProfileError,
      builder: (context, state) {
        String userID = context.read<ServiceBloc>().serviceModel.user!.id;
        List<String> follow = [];
        if (state is OtherProfileLoaded) {
          initFollow.addAll(state.user.follower);
          follow.addAll(state.user.follower);
        }
        if (state is FollowLoading || state is FollowSuccess) {
          if (initFollow.contains(userID)) {
            follow.addAll(initFollow);
            follow.remove(userID);
          } else {
            follow.addAll(initFollow);
            follow.add(userID);
          }
          if (state is FollowSuccess && !initFollow.contains(userID)) {
            initFollow.add(userID);
          } else if (state is FollowSuccess && initFollow.contains(userID)) {
            initFollow.remove(userID);
          }
        }
        return SizedBox(
          width: 120,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              context.read<OtherProfileBloc>().add(FollowUser(id));
            },
            child: Text(follow.contains(userID)
                ? "unfollow".translate(context)
                : "Follow"),
          ),
        );
      },
    );
  }

  Widget buildListPost() {
    return BlocBuilder<OtherProfileBloc, OtherProfileState>(
        buildWhen: (previous, current) =>
            current is InitState ||
            current is PostLoading ||
            current is PostLoaded,
        builder: (_, state) {
          if (state is PostLoaded) {
            return GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 10),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
              ),
              itemCount: state.post.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(createRoute(
                      screen: ViewPostPage(post: state.post[index]),
                      begin: const Offset(1, 0),
                    ));
                  },
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: state.post[index].photo[0],
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/images/post.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_rounded,
                                size: 18,
                                color: Colors.red.withOpacity(0.7),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                state.post[index].liked.length.toString(),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
          return buildLoadingBody();
        });
  }
}
