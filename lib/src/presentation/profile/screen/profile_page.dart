import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_bloc.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_event.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_state.dart';
import 'package:photo_me/src/presentation/view_follow/screen/view_follow_page.dart';
import 'package:photo_me/src/presentation/view_post/screen/view_post_page.dart';

import '../../../../main.dart';
import '../../../core/function/route_function.dart';
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
        builder: (context, state) {
          print(state);
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
                const Text("@ngoctienTNT"),
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
          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget buildListPost() {
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            current is InitState ||
            current is PostLoading ||
            current is PostLoaded,
        builder: (context, state) {
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
                      Image.asset(
                        "assets/images/avatar.jpg",
                        fit: BoxFit.cover,
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
          return const Center(child: CircularProgressIndicator());
        });
  }

  @override
  bool get wantKeepAlive => true;
}
