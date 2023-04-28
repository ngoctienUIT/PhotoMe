import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:permission_handler/permission_handler.dart';

Future saveImage(String url) async {
  var status = await Permission.storage.status;
  if (status.isDenied) {
    await Permission.storage.request();
  }
  status = await Permission.storage.status;
  if (status.isGranted) {
    var url =
        "https://www.kindacode.com/wp-content/uploads/2022/02/orange.jpeg";
    final response = await http.get(Uri.parse(url));

    // Get the image name
    final imageName = path.basename(url);
    // Get the document directory path
    Directory? appDir;

    try {
      if (Platform.isIOS) {
        appDir = await path_provider.getApplicationDocumentsDirectory();
      } else {
        appDir = Directory('/storage/emulated/0/Download/');
        if (!await appDir.exists()) {
          appDir = await path_provider.getExternalStorageDirectory();
        }
      }
    } catch (_) {}

    // This is the saved image path
    // You can use it to display the saved image later
    final localPath = path.join(appDir!.path, imageName);

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);
    Fluttertoast.showToast(msg: localPath);
  }
}
