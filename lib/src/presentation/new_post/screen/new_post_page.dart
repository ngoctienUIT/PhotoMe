import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_me/src/presentation/home/widgets/image_widget.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
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
              onPressed: () {},
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
