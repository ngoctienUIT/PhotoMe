import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../view_image/screen/view_image.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({Key? key, required this.images}) : super(key: key);
  final List<String> images;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final controller = PageController(keepPage: true);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewImage(url: widget.images[index]),
                  ));
                },
                child: Image.asset(widget.images[index], fit: BoxFit.cover),
              );
            },
          ),
          if (widget.images.length > 1)
            Positioned(
              bottom: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: widget.images.length,
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
        ],
      ),
    );
  }
}
