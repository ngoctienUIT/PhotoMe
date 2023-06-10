import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_me/src/core/function/loading_animation.dart';
import 'package:photo_me/src/domain/response/post/post_response.dart';
import 'package:photo_me/src/presentation/home/widgets/image_widget.dart';
import 'package:photo_me/src/presentation/new_post/bloc/new_post_bloc.dart';
import 'package:photo_me/src/presentation/new_post/bloc/new_post_event.dart';
import 'package:photo_me/src/presentation/new_post/bloc/new_post_state.dart';

import '../../../core/bloc/service_bloc.dart';
import '../../../data/model/service_model.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({Key? key, this.post}) : super(key: key);

  final PostResponse? post;

  @override
  Widget build(BuildContext context) {
    ServiceModel serviceModel = context.read<ServiceBloc>().serviceModel;
    return BlocProvider(
      create: (context) => NewPostBloc(serviceModel),
      child: BlocListener<NewPostBloc, NewPostState>(
        listener: (context, state) {
          if (state is NewPostLoading) {
            loadingAnimation(context);
          }
          if (state is NewPostSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        child: NewPostView(post: post),
      ),
    );
  }
}

class NewPostView extends StatefulWidget {
  const NewPostView({Key? key, this.post}) : super(key: key);

  final PostResponse? post;

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  List<XFile> images = [];
  List<String> networkImages = [];
  List<String> deleteImages = [];
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    if (widget.post != null) {
      contentController.text = widget.post!.description;
      networkImages = [...widget.post!.photo];
    }
    super.initState();
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.post != null ? "Update post" : "New Post",
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [buttonUpload()],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Bạn đang nghĩ gì?",
                ),
              ),
            ),
            showListImage(),
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black26, width: 0.5)),
        ),
        height: 100,
        child: Column(
          children: [
            Expanded(
              child: itemPost(FontAwesomeIcons.camera, "Camera", () async {
                var status = await Permission.camera.status;
                if (status.isDenied) {
                  await Permission.camera.request();
                }
                status = await Permission.camera.status;
                if (status.isGranted) {
                  XFile? pickImage =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (pickImage != null) {
                    print(pickImage.path);
                    images.add(pickImage);
                    if (context.mounted) {
                      context.read<NewPostBloc>().add(ChangeImageListEvent());
                    }
                  }
                }
              }),
            ),
            Expanded(
              child: itemPost(FontAwesomeIcons.image, "Thư viện", () async {
                var status = await Permission.storage.status;
                if (status.isDenied) {
                  await Permission.storage.request();
                }
                status = await Permission.storage.status;
                if (status.isGranted) {
                  final List<XFile> images =
                      await ImagePicker().pickMultiImage();
                  // setState(() => this.images.addAll(images));
                  this.images.addAll(images);
                  if (context.mounted) {
                    context.read<NewPostBloc>().add(ChangeImageListEvent());
                  }
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonUpload() {
    return BlocBuilder<NewPostBloc, NewPostState>(
      buildWhen: (previous, current) => current is ChangeImageListState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 0),
            onPressed: images.isNotEmpty || networkImages.isNotEmpty
                ? () {
                    if (widget.post == null) {
                      context.read<NewPostBloc>().add(CreatePostEvent(
                            contentController.text,
                            images.map((e) => e.path).toList(),
                          ));
                    } else {
                      List<String> list = [
                        ...networkImages,
                        ...images.map((e) => e.path).toList()
                      ];
                      context.read<NewPostBloc>().add(UpdatePostEvent(
                          id: widget.post!.id,
                          description: contentController.text,
                          photo: list,
                          deletePhoto: deleteImages));
                    }
                  }
                : null,
            child: Text(widget.post != null ? "Update" : "Upload"),
          ),
        );
      },
    );
  }

  Widget showListImage() {
    return BlocBuilder<NewPostBloc, NewPostState>(
      buildWhen: (previous, current) => current is ChangeImageListState,
      builder: (context, state) {
        return Visibility(
          visible: images.isNotEmpty || networkImages.isNotEmpty,
          child: ImageWidget(
            images: images.map((e) => e.path).toList(),
            networkImages: networkImages,
            showDelete: true,
            onDelete: (index) {
              if (index > networkImages.length - 1) {
                images.removeAt(index - networkImages.length);
              } else {
                deleteImages.add(networkImages[index]);
                networkImages.removeAt(index);
              }
              context.read<NewPostBloc>().add(ChangeImageListEvent());
            },
          ),
        );
      },
    );
  }

  Widget itemPost(IconData icon, String title, VoidCallback onPress) {
    return InkWell(
      onTap: onPress,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(icon),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }
}
