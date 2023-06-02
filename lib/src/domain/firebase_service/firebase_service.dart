import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static Future deleteImage(String url, String id) async {
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
}
