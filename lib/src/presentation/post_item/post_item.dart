import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/domain/response/post/post_response.dart';
import 'package:photo_me/src/presentation/home/widgets/image_widget.dart';
import 'package:photo_me/src/presentation/new_post/screen/new_post_page.dart';
import 'package:photo_me/src/presentation/other_profile/screen/other_profile_page.dart';
import 'package:photo_me/src/presentation/post_item/bloc/post_item_event.dart';
import 'package:photo_me/src/presentation/post_item/bloc/post_item_state.dart';
import 'package:photo_me/src/presentation/view_post/screen/view_post_page.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/function/route_function.dart';
import '../../core/language/bloc/language_bloc.dart';
import '../../core/widgets/custom_alert_dialog.dart';
import 'bloc/post_item_bloc.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key, required this.post, required this.checkViewPost})
      : super(key: key);

  final PostResponse post;
  final bool checkViewPost;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostItemBloc(),
      child: PostItemView(post: post, checkViewPost: checkViewPost),
    );
  }
}

class PostItemView extends StatelessWidget {
  const PostItemView(
      {Key? key, required this.post, required this.checkViewPost})
      : super(key: key);

  final PostResponse post;
  final bool checkViewPost;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostItemBloc, PostItemState>(
      listener: (context, state) {
        if (state is DeleteSuccess && checkViewPost) {
          Navigator.pop(context);
        }
      },
      child: InkWell(
        onTap: () {},
        child: Container(
          color: const Color(0xFFF5F5F5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(createRoute(
                      screen: ViewPostPage(post: post),
                      begin: const Offset(0, 1),
                    ));
                  },
                  child: infoPost(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(post.description),
                ),
              ),
              if (post.photo.isNotEmpty)
                ImageWidget(
                  images: List.generate(
                      post.photo.length, (index) => post.photo[index]),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildFavoriteWidget(),
                    InkWell(
                      onTap: checkViewPost
                          ? null
                          : () {
                              Navigator.of(context).push(createRoute(
                                screen: ViewPostPage(post: post),
                                begin: const Offset(0, 1),
                              ));
                            },
                      child: Row(
                        children: [
                          const Icon(FontAwesomeIcons.comment,
                              color: Colors.black),
                          const SizedBox(width: 5),
                          Text("${post.comments.length} Comment")
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFavoriteWidget() {
    return BlocBuilder<PostItemBloc, PostItemState>(
      buildWhen: (previous, current) =>
          current is LikeLoading ||
          current is LikeSuccess ||
          current is ErrorState ||
          current is InitState,
      builder: (context, state) {
        String userID = context.read<LanguageBloc>().userID ?? "";

        bool checkLike = true;
        List<String> listLike = [];
        if (state is InitState || state is ErrorState) {
          listLike.addAll(post.liked);
          checkLike = post.liked.contains(userID);
        }
        if (state is LikeLoading || state is LikeSuccess) {
          if (post.liked.contains(userID)) {
            listLike.addAll(post.liked);
            listLike.remove(userID);
            checkLike = false;
          } else {
            listLike.addAll(post.liked);
            listLike.add(userID);
            checkLike = true;
          }
          if (state is LikeSuccess && checkLike) {
            post.liked.add(userID);
          } else if (state is LikeSuccess && !checkLike) {
            post.liked.remove(userID);
          }
        }
        return Row(
          children: [
            InkWell(
              onTap: () {
                context.read<PostItemBloc>().add(LikePostEvent(post.id));
              },
              child: Icon(
                checkLike
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: checkLike ? Colors.red : Colors.black,
              ),
            ),
            const SizedBox(width: 5),
            Text("${listLike.length} Like")
          ],
        );
      },
    );
  }

  Widget infoPost(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 55,
          width: 55,
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(createRoute(
                    screen: OtherProfilePage(id: post.user.id),
                    begin: const Offset(0, 1),
                  ));
                },
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: post.user.avatar,
                    height: 50,
                    width: 50,
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
              buildFollowButton(context),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(createRoute(
                  screen: OtherProfilePage(id: post.user.id),
                  begin: const Offset(0, 1),
                ));
              },
              child: Text(
                post.user.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            Text(timeago.format(DateTime.parse(post.registration),
                locale: "vi")),
          ],
        ),
        const Spacer(),
        if (post.user.id == context.read<LanguageBloc>().userID)
          PopupMenuButton<int>(
            padding: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            onSelected: (value) {
              switch (value) {
                case 0:
                  Navigator.of(context).push(createRoute(
                    screen: NewPostPage(post: post),
                    begin: const Offset(0, 1),
                  ));
                  break;
                case 1:
                  _showAlertDialog(context, () {
                    context.read<PostItemBloc>().add(DeletePostEvent(post.id));
                    Navigator.pop(context);
                  });
                  break;
              }
            },
            icon: const Icon(FontAwesomeIcons.ellipsisVertical, size: 20),
            itemBuilder: (context) {
              return [
                itemPopup(
                  text: 'Chỉnh sửa',
                  icon: FontAwesomeIcons.penToSquare,
                  color: const Color.fromRGBO(59, 190, 253, 1),
                  index: 0,
                ),
                // itemPopup(
                //   text: 'Ai có thể xem',
                //   icon: FontAwesomeIcons.globe,
                //   color: const Color.fromRGBO(26, 191, 185, 1),
                //   index: 1,
                // ),
                itemPopup(
                  text: 'Xóa',
                  icon: FontAwesomeIcons.trash,
                  color: const Color.fromRGBO(26, 191, 185, 1),
                  index: 1,
                ),
              ];
            },
          ),
      ],
    );
  }

  Widget buildFollowButton(BuildContext context) {
    return BlocBuilder<PostItemBloc, PostItemState>(
        buildWhen: (previous, current) =>
            current is FollowLoading ||
            current is FollowSuccess ||
            current is ErrorState ||
            current is InitState,
        builder: (_, state) {
          String userID = context.read<LanguageBloc>().userID ?? "";
          bool checkFollow = true;
          if (post.user.id != userID) {
            if (state is InitState || state is ErrorState) {
              checkFollow = post.user.follower.contains(userID);
            }
            if (state is FollowLoading || state is FollowSuccess) {
              if (!post.user.follower.contains(userID)) {
                List<String> listFollow = [];
                listFollow.addAll(post.user.follower);
                listFollow.add(userID);
                checkFollow = true;
              }
              if (state is FollowSuccess && checkFollow) {
                post.user.follower.add(userID);
              }
            }
          }
          return checkFollow
              ? const SizedBox.shrink()
              : Positioned(
                  right: 0,
                  top: 0,
                  child: InkWell(
                    onTap: () {
                      context
                          .read<PostItemBloc>()
                          .add(FollowUserEvent(post.user.id));
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
        });
  }

  PopupMenuItem<int> itemPopup({
    required String text,
    required int index,
    required IconData icon,
    required Color color,
  }) {
    return PopupMenuItem<int>(
      value: index,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(text)
        ],
      ),
    );
  }

  Future _showAlertDialog(BuildContext context, VoidCallback onOK) async {
    return showDialog(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return customAlertDialog(
          context: context,
          title: "Xóa bài viết",
          content: "Bạn muốn xóa bài viết này",
          onOK: onOK,
        );
      },
    );
  }
}
