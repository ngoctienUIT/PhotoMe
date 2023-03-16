import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_me/src/controls/extension/string_extension.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key, this.image, required this.onChange})
      : super(key: key);

  final File? image;
  final Function(File image) onChange;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showImageBottomSheet(context);
      },
      borderRadius: BorderRadius.circular(90),
      child: SizedBox(
        height: 150,
        width: 150,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(90),
          child: Stack(
            children: [
              ClipOval(
                child: image == null
                    ? Image.asset(
                        "assets/images/avatar.jpg",
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      )
                    : Image.file(image!, height: 150),
              ),
              Center(
                child: Image.asset(
                  "assets/images/icon/photographer.png",
                  fit: BoxFit.cover,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showImageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 350,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              itemAction("take_photo".translate(context), () async {
                Navigator.pop(context);
                var status = await Permission.camera.status;
                if (status.isDenied) {
                  await Permission.camera.request();
                }
                status = await Permission.camera.status;
                if (status.isGranted) pickAvatar(true);
              }),
              itemAction("select_image_gallery".translate(context), () async {
                Navigator.pop(context);
                var status = await Permission.storage.status;
                if (status.isDenied) {
                  await Permission.storage.request();
                }
                status = await Permission.storage.status;
                if (status.isGranted) pickAvatar(false);
              }),
              itemAction("view_profile_picture".translate(context), () {}),
              itemAction("delete_profile_picture".translate(context), () {}),
              itemAction(
                "cancel".translate(context),
                () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void pickAvatar(bool checkCamera) async {
    XFile? pickImage = await ImagePicker().pickImage(
        source: checkCamera ? ImageSource.camera : ImageSource.gallery);
    try {
      if (pickImage != null) {
        final cropImage = await ImageCropper().cropImage(
          sourcePath: pickImage.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: [CropAspectRatioPreset.square],
        );
        if (cropImage != null) {
          onChange(File(cropImage.path));
        }
      }
    } on PlatformException catch (_) {}
  }

  Widget itemAction(String text, Function onPress) {
    return InkWell(
      onTap: () => onPress(),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
