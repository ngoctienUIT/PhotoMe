import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_me/src/core/function/loading_animation.dart';
import 'package:photo_me/src/presentation/home/widgets/image_widget.dart';
import 'package:photo_me/src/presentation/new_post/bloc/new_post_bloc.dart';
import 'package:photo_me/src/presentation/new_post/bloc/new_post_event.dart';
import 'package:photo_me/src/presentation/new_post/bloc/new_post_state.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewPostBloc(),
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
        child: const NewPostView(),
      ),
    );
  }
}

class NewPostView extends StatefulWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  List<XFile> images = [];
  TextEditingController contentController = TextEditingController();

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
        title: const Text(
          "New Post",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: () {
                context.read<NewPostBloc>().add(CreatePostEvent(
                      contentController.text,
                      images.map((e) => e.path).toList(),
                    ));
              },
              child: const Text("Upload"),
            ),
          ),
        ],
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
            if (images.isNotEmpty)
              ImageWidget(images: images.map((e) => e.path).toList()),
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
                    setState(() => images.add(pickImage));
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
                  setState(() => this.images.addAll(images));
                }
              }),
            ),
          ],
        ),
      ),
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
