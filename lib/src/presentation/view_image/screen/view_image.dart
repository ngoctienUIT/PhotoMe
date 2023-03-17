import 'package:flutter/material.dart';

class ViewImage extends StatefulWidget {
  const ViewImage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<ViewImage> createState() => _ViewImageImageState();
}

class _ViewImageImageState extends State<ViewImage> {
  late TransformationController controller;
  late TapDownDetails _doubleTapDetails;
  bool check = true;

  @override
  void initState() {
    super.initState();
    controller = TransformationController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: check
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : null,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => setState(() => check = !check),
          onDoubleTap: () {
            if (controller.value != Matrix4.identity()) {
              controller.value = Matrix4.identity();
            } else {
              Offset position = _doubleTapDetails.localPosition;
              // For a 3x zoom
              controller.value = Matrix4.identity()
                ..translate(-position.dx * 2, -position.dy * 2)
                ..scale(3.0);
              // Fox a 2x zoom
              // ..translate(-position.dx, -position.dy)
              // ..scale(2.0);
            }
          },
          onDoubleTapDown: (details) {
            _doubleTapDetails = details;
          },
          child: Center(
            child: InteractiveViewer(
              transformationController: controller,
              clipBehavior: Clip.none,
              minScale: 1,
              maxScale: 4,
              child: Image.asset(widget.url),
            ),
          ),
        ),
      ),
    );
  }
}