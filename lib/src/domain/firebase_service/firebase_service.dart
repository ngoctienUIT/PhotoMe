import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static Future deleteImage(String url) async {
    try {
      Reference reference = FirebaseStorage.instance.ref(url);
      List<String> list = reference.name.split("%2F");
      String name = "${list[0]}/${list[1]}/${list[2].split("?")[0]}";
      print(name);
      FirebaseStorage.instance.ref().child(name).delete();
    } catch (e) {
      print(e);
    }
  }

  static Future deleteFolder(String id) async {
    try {
      String name = "post/$id";
      await FirebaseStorage.instance.ref(name).listAll().then((value) {
        for (var item in value.items) {
          FirebaseStorage.instance.ref(item.fullPath).delete();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<List<String>> uploadImage(List<String> list, String id) async {
    Reference reference = FirebaseStorage.instance.ref();
    List<String> listURL = [];
    for (var item in list) {
      if (!item.contains("https://") && !item.contains("http://")) {
        Reference upload =
            reference.child("post/$id/${DateTime.now().microsecond}");
        final result = await upload.putFile(File(item));
        print(result.ref.fullPath);
        listURL.add(await upload.getDownloadURL());
      } else {
        listURL.add(item);
      }
    }
    return listURL;
  }
}
