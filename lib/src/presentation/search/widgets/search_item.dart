import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final String imgUrl;
  final String name;
  final int numPost;
  final Function() navigate;

  const SearchItem(
      {Key? key,
      required this.imgUrl,
      required this.name,
      required this.numPost,
      required this.navigate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigate,
      child: ListTile(
        leading: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            placeholder: (context, url) =>
                const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            height: 48,
            width: 48,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(name),
        subtitle: Text('$numPost bài viết đã đăng'),
        // trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
