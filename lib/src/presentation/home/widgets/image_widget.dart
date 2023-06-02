import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../view_image/screen/view_image.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({
    Key? key,
    required this.images,
    this.networkImages = const [],
    this.showDelete = false,
    this.onDelete,
  }) : super(key: key);

  final List<String> images;
  final List<String> networkImages;
  final bool showDelete;
  final Function(int index)? onDelete;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final controller = PageController(keepPage: true);
  int currentIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = [];
    list.addAll(widget.networkImages);
    list.addAll(widget.images);
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            onPageChanged: (value) => setState(() => currentIndex = value),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewImage(url: list[index]),
                      ));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: list[index].contains("assets/")
                          ? Image.asset(list[index], fit: BoxFit.cover)
                          : (list[index].contains("https://") ||
                                  list[index].contains("http://")
                              ? CachedNetworkImage(
                                  imageUrl: list[index],
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/post.png",
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.file(
                                  File(list[index]),
                                  fit: BoxFit.cover,
                                )),
                    ),
                  ),
                  if (widget.showDelete)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () => widget.onDelete!(index),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(Icons.close),
                          ),
                        ),
                      ),
                    )
                ],
              );
            },
          ),
          if (list.length > 1)
            Positioned(
              bottom: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: list.length,
                    effect: const ScrollingDotsEffect(
                      // activeDotColor: Colors.red,
                      activeStrokeWidth: 2.6,
                      activeDotScale: 1.3,
                      maxVisibleDots: 5,
                      radius: 8,
                      spacing: 10,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                ),
              ),
            ),
          if (list.length > 1)
            Positioned(
              top: 10,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${currentIndex + 1}/${list.length}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
