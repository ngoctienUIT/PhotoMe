import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'icon_creation.dart';

class BottomSheetFile extends StatelessWidget {
  const BottomSheetFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.insert_drive_file,
                    Colors.indigo,
                    "Document",
                    () async {
                      Navigator.pop(context);
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);

                      if (result != null) {
                        List<File> files =
                            result.paths.map((path) => File(path!)).toList();
                        if (files.isNotEmpty) {
                          for (File file in files) {
                            file.path.split('/').last;
                          }
                        }
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                  const SizedBox(width: 40),
                  iconCreation(
                    Icons.camera_alt,
                    Colors.pink,
                    "Camera",
                    () async {
                      Navigator.pop(context);
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (image != null) {
                          image.path.split('.').last;
                        }
                      } on PlatformException catch (_) {}
                    },
                  ),
                  const SizedBox(width: 40),
                  iconCreation(
                    Icons.insert_photo,
                    Colors.purple,
                    "Gallery",
                    () async {
                      Navigator.pop(context);
                      try {
                        List<XFile>? images =
                            await ImagePicker().pickMultiImage();
                        if (images.isNotEmpty) {
                          for (XFile image in images) {
                            image.path.split('.').last;
                          }
                        }
                      } catch (_) {}
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.headset,
                    Colors.orange,
                    "Audio",
                    () async {
                      Navigator.pop(context);
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.custom,
                        allowedExtensions: ['mp3', 'wav', 'aac'],
                      );

                      if (result != null) {
                        List<File> files =
                            result.paths.map((path) => File(path!)).toList();
                        for (File file in files) {
                          file.path.split('.').last;
                        }
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                  const SizedBox(width: 40),
                  iconCreation(
                    Icons.location_pin,
                    Colors.teal,
                    "Location",
                    () {},
                  ),
                  const SizedBox(width: 40),
                  iconCreation(
                    Icons.person,
                    Colors.blue,
                    "Contact",
                    () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
