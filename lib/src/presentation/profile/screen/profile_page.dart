import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/core/widgets/item_loading.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_bloc.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_event.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_state.dart';
import 'package:photo_me/src/presentation/view_follow/screen/view_follow_page.dart';
import 'package:photo_me/src/presentation/view_post/screen/view_post_page.dart';

import '../../../core/function/route_function.dart';
import '../../../core/language/bloc/language_bloc.dart';
import '../../edit_profile/screen/edit_profile.dart';
import '../../setting/screen/setting_page.dart';
import '../widgets/info_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()
        ..add(GetProfileData())
        ..add(GetPostData()),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       const Spacer(),
      //       const Divider(),
      //       ListTile(
      //           leading: const Icon(Icons.logout),
      //           title: const Text('Sign Out'),
      //           onTap: () {
      //             Navigator.of(context).pushReplacement(createRoute(
      //               screen: const LoginPage(),
      //               begin: const Offset(0, 1),
      //             ));
      //           }),
      //       const Divider(),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          InkWell(
            child: const Icon(FontAwesomeIcons.bars),
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: const SettingPage(),
                begin: const Offset(1, 0),
              ));
            },
          ),
          const SizedBox(width: 10),
        ],
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       Navigator.of(context).push(createRoute(
        //         screen: const MessagePage(),
        //         begin: const Offset(1, 0),
        //       ));
        //     },
        //     child: const Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 15),
        //       child: Icon(FontAwesomeIcons.paperPlane),
        //     ),
        //   ),
        // ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProfileBloc>().add(GetPostData());
        context.read<ProfileBloc>().add(GetProfileData());
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
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            current is InitState ||
            current is ProfileLoading ||
            current is ProfileLoaded,
        builder: (_, state) {
          print(state);
          String userID = context.read<LanguageBloc>().userID ?? "";

          if (state is ProfileLoaded) {
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 5),
                if (state.user.description != null)
                  Text(state.user.description ?? ""),
                const SizedBox(height: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(createRoute(
                      screen: EditProfile(user: state.user),
                      begin: const Offset(0, 1),
                    ));
                  },
                  child: const Text("Edit profile"),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    infoItem("Post", state.user.post!.length, () {}),
                    infoItem("Followers", state.user.follower.length, () {
                      Navigator.of(context).push(createRoute(
                        screen: ViewFollowPage(index: 0, id: userID),
                        begin: const Offset(1, 0),
                      ));
                    }),
                    infoItem("Following", state.user.following.length, () {
                      Navigator.of(context).push(createRoute(
                        screen: ViewFollowPage(index: 1, id: userID),
                        begin: const Offset(1, 0),
                      ));
                    }),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            );
          }
          return _buildLoadingHeader();
        });
  }

  Widget buildListPost() {
    return BlocBuilder<ProfileBloc, ProfileState>(
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
          return _buildLoadingBody();
          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget _buildLoadingHeader() {
    return Column(
      children: [
        Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(90),
            child: itemLoading(150, 150, 90)),
        const SizedBox(height: 20),
        itemLoading(25, 150, 5),
        const SizedBox(height: 5),
        itemLoading(20, 120, 5),
        const SizedBox(height: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            side: const BorderSide(color: Colors.black54),
          ),
          onPressed: null,
          child: const Text("Edit profile"),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            infoItem("Post", 0, () {}),
            infoItem("Followers", 0, () {}),
            infoItem("Following", 0, () {}),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLoadingBody() {
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
      itemCount: 15,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            itemLoading(150, 150, 0),
            Positioned(
              right: 5,
              bottom: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
                      "0",
                      style: TextStyle(color: Colors.black.withOpacity(0.7)),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
