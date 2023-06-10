import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final String imgUrl;
  final String name;
  final Function() navigate;

  const SearchItem(
      {Key? key,
      required this.imgUrl,
      required this.name,
      required this.navigate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigate,
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipOval(
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
              const SizedBox(width: 8),
              Text(
                name,
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
