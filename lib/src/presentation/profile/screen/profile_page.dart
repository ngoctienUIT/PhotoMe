import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_bloc.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_event.dart';
import 'package:photo_me/src/presentation/profile/bloc/profile_state.dart';
import 'package:photo_me/src/presentation/view_follow/screen/view_follow_page.dart';
import 'package:photo_me/src/presentation/view_post/screen/view_post_page.dart';

import '../../../core/function/route_function.dart';
import '../../edit_profile/screen/edit_profile.dart';
import '../../login/screen/login_page.dart';
import '../widgets/info_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(FetchData()),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const Spacer(),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign Out'),
                onTap: () {
                  Navigator.of(context).pushReplacement(createRoute(
                    screen: const LoginPage(),
                    begin: const Offset(0, 1),
                  ));
                }),
            const Divider(),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: InkWell(
        //   child: const Icon(FontAwesomeIcons.bars),
        //   onTap: () {
        //     Navigator.of(context).push(createRoute(
        //       screen: const SettingPage(),
        //       begin: const Offset(-1, 0),
        //     ));
        //   },
        // ),
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
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      print(state);
      if (state is ProfileLoaded) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<ProfileBloc>().add(FetchData());
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Column(
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
                      screen: const EditProfile(),
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
                    infoItem("Followers", state.user.follower!.length, () {
                      Navigator.of(context).push(createRoute(
                        screen: const ViewFollowPage(index: 0),
                        begin: const Offset(1, 0),
                      ));
                    }),
                    infoItem("Following", state.user.following!.length, () {
                      Navigator.of(context).push(createRoute(
                        screen: const ViewFollowPage(index: 1),
                        begin: const Offset(1, 0),
                      ));
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                buildItemPost(),
              ],
            ),
          ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }

  Widget buildItemPost() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoaded) {
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
              child: Image.asset(
                "assets/images/avatar.jpg",
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
