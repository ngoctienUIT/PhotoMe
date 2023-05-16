import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/core/utils/extension/string_extension.dart';
import 'package:photo_me/src/domain/response/comment/comment_response.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/custom_text_input.dart';
import 'package:photo_me/src/presentation/post_item/post_item.dart';
import 'package:photo_me/src/presentation/view_post/bloc/view_post_bloc.dart';
import 'package:photo_me/src/presentation/view_post/bloc/view_post_event.dart';
import 'package:photo_me/src/presentation/view_post/bloc/view_post_state.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/function/route_function.dart';
import '../../../core/language/bloc/language_bloc.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../../../domain/response/post/post_response.dart';
import '../../other_profile/screen/other_profile_page.dart';

class ViewPostPage extends StatelessWidget {
  const ViewPostPage({Key? key, required this.post}) : super(key: key);

  final PostResponse post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewPostBloc()
        ..add(GetComment(post.id))
        ..add(GetPost(post.id)),
      child: ViewPostView(post: post),
    );
  }
}

class ViewPostView extends StatefulWidget {
  const ViewPostView({Key? key, required this.post}) : super(key: key);

  final PostResponse post;

  @override
  State<ViewPostView> createState() => _ViewPostViewState();
}

class _ViewPostViewState extends State<ViewPostView> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewPostBloc, ViewPostState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(title: Text(widget.post.user.name)),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<ViewPostBloc>().add(GetPost(widget.post.id));
            context.read<ViewPostBloc>().add(GetComment(widget.post.id));
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Column(
              children: [
                postItem(),
                const Divider(),
                buildListComment(),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black26, width: 0.5)),
          ),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/images/avatar.jpg",
                  height: 50,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: writeCommentWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget postItem() {
    return BlocBuilder<ViewPostBloc, ViewPostState>(
      buildWhen: (previous, current) =>
          current is InitState ||
          (current is PostSuccess && current.post != widget.post),
      builder: (_, state) {
        PostResponse post = widget.post;
        if (state is PostSuccess && state.post != widget.post) {
          post = state.post;
        }
        return PostItem(post: post, checkViewPost: true);
      },
    );
  }

  Widget writeCommentWidget() {
    return BlocBuilder<ViewPostBloc, ViewPostState>(
      buildWhen: (previous, current) =>
          current is InitState || current is WriteCommentState,
      builder: (_, state) {
        bool check = false;
        if (state is WriteCommentState) check = state.check;
        return CustomTextInput(
          controller: commentController,
          hint: "Thêm bình luận",
          radius: 30,
          contentPadding: const EdgeInsets.all(10),
          onChange: (text) {
            context.read<ViewPostBloc>().add(WriteComment(text.isNotEmpty));
          },
          suffixIcon: check
              ? InkWell(
                  onTap: () {
                    context.read<ViewPostBloc>().add(
                        CommentPost(widget.post.id, commentController.text));
                    commentController.text = "";
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: const Icon(
                    FontAwesomeIcons.paperPlane,
                    color: Colors.black,
                  ),
                )
              : null,
        );
      },
    );
  }

  Widget buildListComment() {
    return BlocBuilder<ViewPostBloc, ViewPostState>(
      buildWhen: (previous, current) =>
          current is InitState || current is CommentSuccess,
      builder: (_, state) {
        if (state is CommentSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.list.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  commentItem(context, state.list[index]),
                  const SizedBox(height: 15),
                ],
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future _showSimpleDialog(
      BuildContext context, CommentResponse comment) async {
    await showDialog(
        context: context,
        builder: (_) {
          return SimpleDialog(
            // title: const Text('Select Booking Type'),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Gửi đến bạn bè',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(
                      text: "${comment.user.name}: ${comment.comment}"));
                  if (context.mounted) Navigator.of(context).pop();
                },
                child: const Text(
                  'Sao chép',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if (context.read<LanguageBloc>().userID == comment.user.id)
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showAlertDialog(context, () {
                      context
                          .read<ViewPostBloc>()
                          .add(DeleteComment(comment.idPost!, comment.id));
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    'Xóa',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          );
        });
  }

  Future _showAlertDialog(BuildContext context, VoidCallback onOK) async {
    return showDialog(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return customAlertDialog(
          context: context,
          title: "Xóa bình luận",
          content: "Bạn muốn xóa bình luận này",
          onOK: onOK,
        );
      },
    );
  }

  Widget commentItem(BuildContext context, CommentResponse comment) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: () {
        _showSimpleDialog(context, comment);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: OtherProfilePage(id: comment.user.id),
                begin: const Offset(0, 1),
              ));
            },
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: comment.user.avatar,
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
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(createRoute(
                      screen: OtherProfilePage(id: comment.user.id),
                      begin: const Offset(0, 1),
                    ));
                  },
                  child: Text(
                    comment.user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                Text(comment.comment),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      timeago.format(comment.registration.toDateTime(),
                          locale: "vi"),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 10),
                    InkWell(onTap: () {}, child: const Text("Trả lời")),
                    const Spacer(),
                    buildFavoriteWidget(comment),
                    const SizedBox(width: 25),
                    // InkWell(
                    //   onTap: () {},
                    //   child: const Icon(FontAwesomeIcons.thumbsDown),
                    // ),
                    // const SizedBox(width: 3),
                    // Text(comment.liked.length.toString()),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildFavoriteWidget(CommentResponse comment) {
    return BlocBuilder<ViewPostBloc, ViewPostState>(
      buildWhen: (previous, current) =>
          (current is LikeCommentLoading && current.id == comment.id) ||
          (current is LikeCommentSuccess && current.id == comment.id) ||
          current is ErrorState ||
          current is InitState ||
          current is CommentSuccess,
      builder: (_, state) {
        String userID = context.read<LanguageBloc>().userID ?? "";

        bool checkLike = false;
        List<String> listLike = [];
        if (state is InitState ||
            state is ErrorState ||
            state is CommentSuccess) {
          listLike.addAll(comment.liked);
          checkLike = comment.liked.contains(userID);
        }
        if (state is LikeCommentLoading || state is LikeCommentSuccess) {
          if (comment.liked.contains(userID)) {
            listLike.addAll(comment.liked);
            listLike.remove(userID);
            checkLike = false;
          } else {
            listLike.addAll(comment.liked);
            listLike.add(userID);
            checkLike = true;
          }
          if (state is LikeCommentSuccess && checkLike) {
            comment.liked.add(userID);
          } else if (state is LikeCommentSuccess && !checkLike) {
            comment.liked.remove(userID);
          }
        }
        return Row(
          children: [
            InkWell(
              onTap: () {
                context.read<ViewPostBloc>().add(LikeComment(comment.id));
              },
              child: Icon(
                checkLike
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: checkLike ? Colors.red : Colors.black,
              ),
            ),
            const SizedBox(width: 3),
            Text(listLike.length.toString()),
          ],
        );
      },
    );
  }
}
