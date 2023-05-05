import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_me/src/domain/response/comment/comment_response.dart';
import 'package:photo_me/src/presentation/edit_profile/widgets/custom_text_input.dart';
import 'package:photo_me/src/presentation/post_item/post_item.dart';
import 'package:photo_me/src/presentation/view_post/bloc/view_post_bloc.dart';
import 'package:photo_me/src/presentation/view_post/bloc/view_post_event.dart';
import 'package:photo_me/src/presentation/view_post/bloc/view_post_state.dart';

import '../../../domain/response/post/post_response.dart';

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
          current is InitState || current is PostSuccess,
      builder: (context, state) {
        print(state);
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
      builder: (context, state) {
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
      builder: (context, state) {
        print(state);
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

  Future _showSimpleDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
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
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Sao chép',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
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

  Widget commentItem(BuildContext context, CommentResponse comment) {
    return GestureDetector(
      onLongPress: () {
        _showSimpleDialog(context);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
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
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.user.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(comment.comment),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Flexible(
                        child: Text(
                      comment.registration,
                      overflow: TextOverflow.ellipsis,
                    )),
                    const SizedBox(width: 10),
                    InkWell(onTap: () {}, child: const Text("Trả lời")),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: const Icon(FontAwesomeIcons.heart),
                    ),
                    const SizedBox(width: 3),
                    Text(comment.liked.length.toString()),
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
}
